{ lib, python3Packages, fetchPypi }:

python3Packages.buildPythonApplication rec {
  pname = "awscli-local";
  version = "0.22.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-OAfPLuS73U3038i+8CfyW95SPcr4EZcg9nftleu6ZqQ=";
  };

  build-system = with python3Packages; [ setuptools ];

  dependencies = with python3Packages; [
    python-hcl2
    packaging
    localstack-client
  ];

  # Can’t run `pytestCheckHook` because the tests are integration tests and expect localstack to be present, which in turn expects docker to be running.
  doCheck = false;

  # There is no `pythonImportsCheck` because the package only outputs a binary: awslocal
  dontUsePythonImportsCheck = true;

  meta = with lib; {
    description = ''Thin wrapper around the "aws" command line interface for use with LocalStack'';
    homepage = "https://github.com/localstack/awscli-local";
    license = licenses.asl20;
  };
}
