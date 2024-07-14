# {
#   description = "A very basic flake";
# 
#   inputs = {
#     nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
#   };
# 
#   outputs = { self, nixpkgs }: {
# 
#      packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
#  
#      packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
# 
#   };
# }

{
	description = "Enable Plymouth";
	# From NixOS Discourse "How do people work on Plymouth themes on NixOS?"
	
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
		fu.url = "github:numtide/flake-utils";
	};

	outputs = { self, nixpkgs, fu }: fu.lib.eachDefaultSystem (system: let
		projectPath = builtins.toString ./.;
		pkgs = nixpkgs.legacyPackages.${system};

		plymouthConfPackage = pkgs.runCommand "build-plymouth-conf-package" {} ''
			mkdir $out
			mkdir -p $out/etc/plymouth/themes/testing
			cat <<EOF > "$out/etc/plymouth/plymouthd.conf" 
[Daemon]
ShowDelay=0
DeviceTimeout=8
Theme=testing
EOF
			ln -s ${pkgs.plymouth}/lib/plymouth $out/etc/plymouth/plugins
			ln -s ${pkgs.plymouth}/share/plymouth/plymouthd.defaults $out/etc/plymouth/plymouthd.defaults
		'';

		env = pkgs.buildFHSEnvBubblewrap {
			name = "plymouthFHSEnv";
			targetPkgs = p: with p; [
				plymouth
			];
			runScript = ''
				bash
			'';
			extraBwrapArgs = [
				"--ro-bind" "${plymouthConfPackage}/etc/plymouth" "/etc/plymouth" 
				"--ro-bind" "${projectPath}/" "/etc/plymouth/themes/testing"
			];
		};
	in {
		devShells.default = env.env;
	});
	nixosConfigurations."edenlinux".config.system.build.toplevel = 9;
}
