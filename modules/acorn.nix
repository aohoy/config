{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "acorn";
  version = "0.9.1";

  src = fetchFromGitHub {
    owner = "acorn-io";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-ZS3YxXgMSu8+eRnpqrtaBTQIlSY3cscudcTbztiRsbM=";
  };

  vendorHash = "sha256-jkkzlMc2y8HvPZjpmRIQz64JK5yjhdoJevE0dclBHvA=";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/acorn-io/acorn/pkg/version.Tag=v${version}"
  ];

  CGO_ENABLED = 0;

  # integration tests require network and kubernetes master
  doCheck = false;

  postInstall = ''
  mv $out/bin/runtime $out/bin/acorn
  '';

  meta = with lib; {
    homepage = "https://docs.acorn.io";
    changelog = "https://github.com/acorn-io/${pname}/releases/tag/v${version}";
    description = "A simple application deployment framework for Kubernetes";
    license = licenses.asl20;
    maintainers = with maintainers; [ urandom ];
  };
}
