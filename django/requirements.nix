# generated using pypi2nix tool (version: 2.0.4)
# See more at: https://github.com/nix-community/pypi2nix
#
# COMMAND:
#   pypi2nix -r requirements.txt -O ../overrides.nix --no-default-overrides -s pytest-runner
#

{ pkgs ? import <nixpkgs> {},
  overrides ? ({ pkgs, python }: self: super: {})
}:

let

  inherit (pkgs) makeWrapper;
  inherit (pkgs.stdenv.lib) fix' extends inNixShell;

  pythonPackages =
  import "${toString pkgs.path}/pkgs/top-level/python-packages.nix" {
    inherit pkgs;
    inherit (pkgs) stdenv;
    python = pkgs.python3;
  };

  commonBuildInputs = [];
  commonDoCheck = false;

  withPackages = pkgs':
    let
      pkgs = builtins.removeAttrs pkgs' ["__unfix__"];
      interpreterWithPackages = selectPkgsFn: pythonPackages.buildPythonPackage {
        name = "python3-interpreter";
        buildInputs = [ makeWrapper ] ++ (selectPkgsFn pkgs);
        buildCommand = ''
          mkdir -p $out/bin
          ln -s ${pythonPackages.python.interpreter} \
              $out/bin/${pythonPackages.python.executable}
          for dep in ${builtins.concatStringsSep " "
              (selectPkgsFn pkgs)}; do
            if [ -d "$dep/bin" ]; then
              for prog in "$dep/bin/"*; do
                if [ -x "$prog" ] && [ -f "$prog" ]; then
                  ln -s $prog $out/bin/`basename $prog`
                fi
              done
            fi
          done
          for prog in "$out/bin/"*; do
            wrapProgram "$prog" --prefix PYTHONPATH : "$PYTHONPATH"
          done
          pushd $out/bin
          ln -s ${pythonPackages.python.executable} python
          ln -s ${pythonPackages.python.executable} \
              python3
          popd
        '';
        passthru.interpreter = pythonPackages.python;
      };

      interpreter = interpreterWithPackages builtins.attrValues;
    in {
      __old = pythonPackages;
      inherit interpreter;
      inherit interpreterWithPackages;
      mkDerivation = args: pythonPackages.buildPythonPackage (args // {
        nativeBuildInputs = (args.nativeBuildInputs or []) ++ args.buildInputs;
      });
      packages = pkgs;
      overrideDerivation = drv: f:
        pythonPackages.buildPythonPackage (
          drv.drvAttrs // f drv.drvAttrs // { meta = drv.meta; }
        );
      withPackages = pkgs'':
        withPackages (pkgs // pkgs'');
    };

  python = withPackages {};

  generated = self: {
    "amqp" = python.mkDerivation {
      name = "amqp-2.6.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/21/2e/3f06f2e063c6548a399f1eb221d9d128de1f29c4ee7a4a9bb0e0d33f3ca8/amqp-2.6.0.tar.gz";
        sha256 = "24dbaff8ce4f30566bb88976b398e8c4e77637171af3af6f1b9650f48890e60b";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [

      ];
      propagatedBuildInputs = [
        self."vine"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/celery/py-amqp";
        license = licenses.bsdOriginal;
        description = "Low-level AMQP client for Python (fork of amqplib).";
      };
    };

    "asgiref" = python.mkDerivation {
      name = "asgiref-3.2.7";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/30/c1/bbde4e26250ca00c9aae5c7bd73ee1785d1a0665b1ae18481127bb0c00d0/asgiref-3.2.7.tar.gz";
        sha256 = "8036f90603c54e93521e5777b2b9a39ba1bad05773fcf2d208f0299d1df58ce5";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [

      ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/django/asgiref/";
        license = licenses.bsdOriginal;
        description = "ASGI specs, helper code, and adapters";
      };
    };

    "attrs" = python.mkDerivation {
      name = "attrs-19.3.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/98/c3/2c227e66b5e896e15ccdae2e00bbc69aa46e9a8ce8869cc5fa96310bf612/attrs-19.3.0.tar.gz";
        sha256 = "f7b7ce16570fe9965acd6d30101a28f62fb4a7f9e926b3bbc9b61f8b04247e72";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [
        self."setuptools"
        self."wheel"
      ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://www.attrs.org/";
        license = licenses.mit;
        description = "Classes Without Boilerplate";
      };
    };

    "billiard" = python.mkDerivation {
      name = "billiard-3.6.3.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/25/3d/41855540b25ac553ec8f34875cf144da7a3f86ec148222372d148247940f/billiard-3.6.3.0.tar.gz";
        sha256 = "d91725ce6425f33a97dfa72fb6bfef0e47d4652acd98a032bd1a7fbf06d5fa6a";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [

      ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/celery/billiard";
        license = licenses.bsdOriginal;
        description = "Python multiprocessing fork with improvements and bugfixes";
      };
    };

    "celery" = python.mkDerivation {
      name = "celery-4.4.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/73/51/e6087399e2cd37c6b029ae59d045a74adfa7aa764c557df9c73e4cdd6e37/celery-4.4.3.tar.gz";
        sha256 = "5147662e23dc6bc39c17a2cbc9a148debe08ecfb128b0eded14a0d9c81fc5742";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [

      ];
      propagatedBuildInputs = [
        self."billiard"
        self."kombu"
        self."pytz"
        self."vine"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://celeryproject.org";
        license = licenses.bsdOriginal;
        description = "Distributed Task Queue.";
      };
    };

    "django" = python.mkDerivation {
      name = "django-3.0.6";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/1e/9b/75ef2ff5482f2970ba59093a67b9a8371626af8559caca7fcdb16ea4bd1c/Django-3.0.6.tar.gz";
        sha256 = "9aaa6a09678e1b8f0d98a948c56482eac3e3dd2ddbfb8de70a868135ef3b5e01";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [

      ];
      propagatedBuildInputs = [
        self."asgiref"
        self."pytz"
        self."sqlparse"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://www.djangoproject.com/";
        license = licenses.bsdOriginal;
        description = "A high-level Python Web framework that encourages rapid development and clean, pragmatic design.";
      };
    };

    "django-classy-tags" = python.mkDerivation {
      name = "django-classy-tags-1.0.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/19/22/39385390e854356a1267d246d9ac6ed45fd0b90c7ec422c2ce7aea647d25/django-classy-tags-1.0.0.tar.gz";
        sha256 = "ad6a25fc2b58a098f00d86bd5e5dad47922f5ca4e744bc3cccb7b4be5bc35eb1";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [

      ];
      propagatedBuildInputs = [
        self."django"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/ojii/django-classy-tags";
        license = licenses.bsdOriginal;
        description = "Class based template tags for Django";
      };
    };

    "django-cms" = python.mkDerivation {
      name = "django-cms-3.7.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/9a/bd/969dd9047db460a678180bbdb5683ec31285e996c8b8aee231e47807faea/django-cms-3.7.3.tar.gz";
        sha256 = "a93c0ceabf4ae29e6b4a7c18d538f26370e8375a9852dac2a1428ebb876ff606";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [

      ];
      propagatedBuildInputs = [
        self."django"
        self."django-classy-tags"
        self."django-formtools"
        self."django-sekizai"
        self."django-treebeard"
        self."djangocms-admin-style"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://www.django-cms.org/";
        license = licenses.bsdOriginal;
        description = "An Advanced Django CMS";
      };
    };

    "django-debug-toolbar" = python.mkDerivation {
      name = "django-debug-toolbar-2.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/7d/ee/ef1ae02385765e5511f7e870fade9bdbd4f3025ce3f4e9bfb2ce52e87bdf/django-debug-toolbar-2.2.tar.gz";
        sha256 = "eabbefe89881bbe4ca7c980ff102e3c35c8e8ad6eb725041f538988f2f39a943";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [

      ];
      propagatedBuildInputs = [
        self."django"
        self."sqlparse"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/jazzband/django-debug-toolbar";
        license = licenses.bsdOriginal;
        description = "A configurable set of panels that display various debug information about the current request/response.";
      };
    };

    "django-formtools" = python.mkDerivation {
      name = "django-formtools-2.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/ca/bb/7d8a1bff28bcb9031264dfc0e5cb288d369a6da5d7827e2f799025f41eb7/django-formtools-2.2.tar.gz";
        sha256 = "c5272c03c1cd51b2375abf7397a199a3148a9fbbf2f100e186467a84025d13b2";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [

      ];
      propagatedBuildInputs = [
        self."django"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://django-formtools.readthedocs.io/en/latest/";
        license = licenses.bsdOriginal;
        description = "A set of high-level abstractions for Django forms";
      };
    };

    "django-sekizai" = python.mkDerivation {
      name = "django-sekizai-1.1.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/d8/78/d058bc163eb3ddff0dfcc43a07d67fbfae4b76eb18827e27b847543c6c77/django-sekizai-1.1.0.tar.gz";
        sha256 = "e2f6e666d4dd9d3ecc27284acb85ef709e198014f5d5af8c6d54ed04c2d684d9";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [

      ];
      propagatedBuildInputs = [
        self."django"
        self."django-classy-tags"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/ojii/django-sekizai";
        license = licenses.bsdOriginal;
        description = "Django Sekizai";
      };
    };

    "django-treebeard" = python.mkDerivation {
      name = "django-treebeard-4.3.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/d0/6a/8ddd748a364230a481512160286c1ea8e50c345ba2422af0a349ac8601d5/django-treebeard-4.3.1.tar.gz";
        sha256 = "83aebc34a9f06de7daaec330d858d1c47887e81be3da77e3541fe7368196dd8a";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [

      ];
      propagatedBuildInputs = [
        self."django"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/django-treebeard/django-treebeard/";
        license = licenses.asl20;
        description = "Efficient tree implementations for Django";
      };
    };

    "djangocms-admin-style" = python.mkDerivation {
      name = "djangocms-admin-style-1.5.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/97/bc/b4502271db3e7c0e1a9a17e8ac4fe13d19c6305a133e1ebf17ed54e56ae2/djangocms-admin-style-1.5.0.tar.gz";
        sha256 = "47d9868aa448e593ce90059d6542a4d907c120d357cd0561c586f5557e3ba316";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [

      ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/divio/djangocms-admin-style";
        license = licenses.bsdOriginal;
        description = "Adds pretty CSS styles for the django CMS admin interface.";
      };
    };

    "djangorestframework" = python.mkDerivation {
      name = "djangorestframework-3.11.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/80/f6/f742b0352d4ade1934fcb2a12f6fd669922415bea3d5d2d6596dc47abe14/djangorestframework-3.11.0.tar.gz";
        sha256 = "e782087823c47a26826ee5b6fa0c542968219263fb3976ec3c31edab23a4001f";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [

      ];
      propagatedBuildInputs = [
        self."django"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://www.django-rest-framework.org/";
        license = licenses.bsdOriginal;
        description = "Web APIs for Django, made easy.";
      };
    };

    "flake8" = python.mkDerivation {
      name = "flake8-3.8.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/10/b1/ef9620afac4a8794e631e54bbcd2f70257dee04693ea8fd959d57b89714e/flake8-3.8.2.tar.gz";
        sha256 = "c69ac1668e434d37a2d2880b3ca9aafd54b3a10a3ac1ab101d22f29e29cf8634";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [

      ];
      propagatedBuildInputs = [
        self."importlib-metadata"
        self."mccabe"
        self."pycodestyle"
        self."pyflakes"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://gitlab.com/pycqa/flake8";
        license = licenses.mit;
        description = "the modular source code checker: pep8 pyflakes and co";
      };
    };

    "flake8-django" = python.mkDerivation {
      name = "flake8-django-1.1.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/9d/66/f8efb5648770ba1153e2a3edcce2c77cdd83a728b91e1529b96e1e52c587/flake8-django-1.1.1.tar.gz";
        sha256 = "fb4e8f669d3cf44297bb6e1c5d0a358ab0aba373cd4c69268cf2798de6bcbd9b";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [

      ];
      propagatedBuildInputs = [
        self."flake8"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/rocioar/flake8-django";
        license = licenses.mit;
        description = "Plugin to catch bad style specific to Django Projects";
      };
    };

    "importlib-metadata" = python.mkDerivation {
      name = "importlib-metadata-1.6.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/b4/1b/baab42e3cd64c9d5caac25a9d6c054f8324cdc38975a44d600569f1f7158/importlib_metadata-1.6.0.tar.gz";
        sha256 = "34513a8a0c4962bc66d35b359558fd8a5e10cd472d37aec5f66858addef32c1e";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [
        self."setuptools"
        self."setuptools-scm"
        self."wheel"
      ];
      propagatedBuildInputs = [
        self."zipp"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://importlib-metadata.readthedocs.io/";
        license = licenses.asl20;
        description = "Read metadata from Python packages";
      };
    };

    "kombu" = python.mkDerivation {
      name = "kombu-4.6.9";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/1b/5a/c7dcbde12fc20a0842e5852a29cefb3b425ef1ecf373d19a1b7f92d264a6/kombu-4.6.9.tar.gz";
        sha256 = "aece08f48706743aaa1b9d607fee300559481eafcc5ee56451aa0ef867a3be07";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [

      ];
      propagatedBuildInputs = [
        self."amqp"
        self."importlib-metadata"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://kombu.readthedocs.io";
        license = licenses.bsdOriginal;
        description = "Messaging library for Python.";
      };
    };

    "mccabe" = python.mkDerivation {
      name = "mccabe-0.6.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/06/18/fa675aa501e11d6d6ca0ae73a101b2f3571a565e0f7d38e062eec18a91ee/mccabe-0.6.1.tar.gz";
        sha256 = "dd8d182285a0fe56bace7f45b5e7d1a6ebcbf524e8f3bd87eb0f125271b8831f";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [

      ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pycqa/mccabe";
        license = licenses.mit;
        description = "McCabe checker, plugin for flake8";
      };
    };

    "more-itertools" = python.mkDerivation {
      name = "more-itertools-8.3.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/16/e8/b371710ad458e56b6c74b82352fdf1625e75c03511c66a75314f1084f057/more-itertools-8.3.0.tar.gz";
        sha256 = "558bb897a2232f5e4f8e2399089e35aecb746e1f9191b6584a151647e89267be";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [

      ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/more-itertools/more-itertools";
        license = licenses.mit;
        description = "More routines for operating on iterables, beyond itertools";
      };
    };

    "packaging" = python.mkDerivation {
      name = "packaging-20.4";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/55/fd/fc1aca9cf51ed2f2c11748fa797370027babd82f87829c7a8e6dbe720145/packaging-20.4.tar.gz";
        sha256 = "4357f74f47b9c12db93624a82154e9b120fa8293699949152b22065d556079f8";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [

      ];
      propagatedBuildInputs = [
        self."pyparsing"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pypa/packaging";
        license = licenses.asl20;
        description = "Core utilities for Python packages";
      };
    };

    "pluggy" = python.mkDerivation {
      name = "pluggy-0.13.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/f8/04/7a8542bed4b16a65c2714bf76cf5a0b026157da7f75e87cc88774aa10b14/pluggy-0.13.1.tar.gz";
        sha256 = "15b2acde666561e1298d71b523007ed7364de07029219b604cf808bfa1c765b0";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [
        self."setuptools"
        self."setuptools-scm"
        self."wheel"
      ];
      propagatedBuildInputs = [
        self."importlib-metadata"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pytest-dev/pluggy";
        license = licenses.mit;
        description = "plugin and hook calling mechanisms for python";
      };
    };

    "py" = python.mkDerivation {
      name = "py-1.8.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/bd/8f/169d08dcac7d6e311333c96b63cbe92e7947778475e1a619b674989ba1ed/py-1.8.1.tar.gz";
        sha256 = "5e27081401262157467ad6e7f851b7aa402c5852dbcb3dae06768434de5752aa";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [

      ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://py.readthedocs.io/";
        license = licenses.mit;
        description = "library with cross-python path, ini-parsing, io, code, log facilities";
      };
    };

    "pycodestyle" = python.mkDerivation {
      name = "pycodestyle-2.6.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/bb/82/0df047a5347d607be504ad5faa255caa7919562962b934f9372b157e8a70/pycodestyle-2.6.0.tar.gz";
        sha256 = "c58a7d2815e0e8d7972bf1803331fb0152f867bd89adf8a01dfd55085434192e";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [

      ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pycodestyle.readthedocs.io/";
        license = licenses.mit;
        description = "Python style guide checker";
      };
    };

    "pyflakes" = python.mkDerivation {
      name = "pyflakes-2.2.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/f1/e2/e02fc89959619590eec0c35f366902535ade2728479fc3082c8af8840013/pyflakes-2.2.0.tar.gz";
        sha256 = "35b2d75ee967ea93b55750aa9edbbf72813e06a66ba54438df2cfac9e3c27fc8";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [

      ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/PyCQA/pyflakes";
        license = licenses.mit;
        description = "passive checker of Python programs";
      };
    };

    "pyparsing" = python.mkDerivation {
      name = "pyparsing-2.4.7";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/c1/47/dfc9c342c9842bbe0036c7f763d2d6686bcf5eb1808ba3e170afdb282210/pyparsing-2.4.7.tar.gz";
        sha256 = "c203ec8783bf771a155b207279b9bccb8dea02d8f0c9e5f8ead507bc3246ecc1";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [

      ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pyparsing/pyparsing/";
        license = licenses.mit;
        description = "Python parsing module";
      };
    };

    "pytest" = python.mkDerivation {
      name = "pytest-5.4.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/49/10/4a8f2f7828b195fe9c9e2b910e9b0dd3d4a263bffbab54f09bf6c2f488bb/pytest-5.4.2.tar.gz";
        sha256 = "eb2b5e935f6a019317e455b6da83dd8650ac9ffd2ee73a7b657a30873d67a698";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [
        self."setuptools"
        self."setuptools-scm"
        self."wheel"
      ];
      propagatedBuildInputs = [
        self."attrs"
        self."importlib-metadata"
        self."more-itertools"
        self."packaging"
        self."pluggy"
        self."py"
        self."wcwidth"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.pytest.org/en/latest/";
        license = licenses.mit;
        description = "pytest: simple powerful testing with Python";
      };
    };

    "pytest-django" = python.mkDerivation {
      name = "pytest-django-3.9.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/38/70/6641c8b28b2f5f98a22b0cc40fb7920469547549016fa65e941a45ae8c0f/pytest-django-3.9.0.tar.gz";
        sha256 = "664e5f42242e5e182519388f01b9f25d824a9feb7cd17d8f863c8d776f38baf9";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [

      ];
      propagatedBuildInputs = [
        self."pytest"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pytest-django.readthedocs.io/";
        license = licenses.bsdOriginal;
        description = "A Django plugin for pytest.";
      };
    };

    "pytest-runner" = python.mkDerivation {
      name = "pytest-runner-5.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/5b/82/1462f86e6c3600f2471d5f552fcc31e39f17717023df4bab712b4a9db1b3/pytest-runner-5.2.tar.gz";
        sha256 = "96c7e73ead7b93e388c5d614770d2bae6526efd997757d3543fe17b557a0942b";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [
        self."setuptools"
        self."setuptools-scm"
        self."wheel"
      ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pytest-dev/pytest-runner/";
        license = licenses.mit;
        description = "Invoke py.test as distutils command with dependency resolution";
      };
    };

    "pytz" = python.mkDerivation {
      name = "pytz-2020.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/f4/f6/94fee50f4d54f58637d4b9987a1b862aeb6cd969e73623e02c5c00755577/pytz-2020.1.tar.gz";
        sha256 = "c35965d010ce31b23eeb663ed3cc8c906275d6be1a34393a1d73a41febf4a048";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [

      ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pythonhosted.org/pytz";
        license = licenses.mit;
        description = "World timezone definitions, modern and historical";
      };
    };

    "setuptools" = python.mkDerivation {
      name = "setuptools-47.1.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/25/bf/a37e89d3148221fedd4def62bb68749041d79f3840d58a7943f81a6f6c6e/setuptools-47.1.1.zip";
        sha256 = "145fa62b9d7bb544fce16e9b5a9bf4ab2032d2f758b7cd674af09a92736aff74";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [

      ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pypa/setuptools";
        license = licenses.mit;
        description = "Easily download, build, install, upgrade, and uninstall Python packages";
      };
    };

    "setuptools-scm" = python.mkDerivation {
      name = "setuptools-scm-4.1.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/cd/66/fa77e809b7cb1c2e14b48c7fc8a8cd657a27f4f9abb848df0c967b6e4e11/setuptools_scm-4.1.2.tar.gz";
        sha256 = "a8994582e716ec690f33fec70cca0f85bd23ec974e3f783233e4879090a7faa8";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [
        self."setuptools"
        self."wheel"
      ];
      propagatedBuildInputs = [
        self."setuptools"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pypa/setuptools_scm/";
        license = licenses.mit;
        description = "the blessed package to manage your versions by scm tags";
      };
    };

    "six" = python.mkDerivation {
      name = "six-1.15.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/6b/34/415834bfdafca3c5f451532e8a8d9ba89a21c9743a0c59fbd0205c7f9426/six-1.15.0.tar.gz";
        sha256 = "30639c035cdb23534cd4aa2dd52c3bf48f06e5f4a941509c8bafd8ce11080259";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [

      ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/benjaminp/six";
        license = licenses.mit;
        description = "Python 2 and 3 compatibility utilities";
      };
    };

    "sqlparse" = python.mkDerivation {
      name = "sqlparse-0.3.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/67/4b/253b6902c1526885af6d361ca8c6b1400292e649f0e9c95ee0d2e8ec8681/sqlparse-0.3.1.tar.gz";
        sha256 = "e162203737712307dfe78860cc56c8da8a852ab2ee33750e33aeadf38d12c548";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [

      ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/andialbrecht/sqlparse";
        license = licenses.bsdOriginal;
        description = "Non-validating SQL parser";
      };
    };

    "toml" = python.mkDerivation {
      name = "toml-0.10.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/da/24/84d5c108e818ca294efe7c1ce237b42118643ce58a14d2462b3b2e3800d5/toml-0.10.1.tar.gz";
        sha256 = "926b612be1e5ce0634a2ca03470f95169cf16f939018233a670519cb4ac58b0f";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [

      ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/uiri/toml";
        license = licenses.mit;
        description = "Python Library for Tom's Obvious, Minimal Language";
      };
    };

    "vine" = python.mkDerivation {
      name = "vine-1.3.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/1c/e1/79fb8046e607dd6c2ad05c9b8ebac9d0bd31d086a08f02699e96fc5b3046/vine-1.3.0.tar.gz";
        sha256 = "133ee6d7a9016f177ddeaf191c1f58421a1dcc6ee9a42c58b34bed40e1d2cd87";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [

      ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/celery/vine";
        license = licenses.bsdOriginal;
        description = "Promises, promises, promises.";
      };
    };

    "wcwidth" = python.mkDerivation {
      name = "wcwidth-0.1.9";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/25/9d/0acbed6e4a4be4fc99148f275488580968f44ddb5e69b8ceb53fc9df55a0/wcwidth-0.1.9.tar.gz";
        sha256 = "ee73862862a156bf77ff92b09034fc4825dd3af9cf81bc5b360668d425f3c5f1";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [

      ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/jquast/wcwidth";
        license = licenses.mit;
        description = "Measures number of Terminal column cells of wide-character codes";
      };
    };

    "wheel" = python.mkDerivation {
      name = "wheel-0.34.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/75/28/521c6dc7fef23a68368efefdcd682f5b3d1d58c2b90b06dc1d0b805b51ae/wheel-0.34.2.tar.gz";
        sha256 = "8788e9155fe14f54164c1b9eb0a319d98ef02c160725587ad60f14ddc57b6f96";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [
        self."setuptools"
      ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pypa/wheel";
        license = licenses.mit;
        description = "A built-package format for Python";
      };
    };

    "zipp" = python.mkDerivation {
      name = "zipp-3.1.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/ce/8c/2c5f7dc1b418f659d36c04dec9446612fc7b45c8095cc7369dd772513055/zipp-3.1.0.tar.gz";
        sha256 = "c599e4d75c98f6798c509911d08a22e6c021d074469042177c8c86fb92eefd96";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [
        self."setuptools"
        self."setuptools-scm"
        self."wheel"
      ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/jaraco/zipp";
        license = licenses.mit;
        description = "Backport of pathlib-compatible object wrapper for zip files";
      };
    };
  };
  localOverridesFile = ./requirements_override.nix;
  localOverrides = import localOverridesFile { inherit pkgs python; };
  commonOverrides = [
        (import (../overrides.nix) { inherit pkgs python ; })
  ];
  paramOverrides = [
    (overrides { inherit pkgs python; })
  ];
  allOverrides =
    (if (builtins.pathExists localOverridesFile)
     then [localOverrides] else [] ) ++ commonOverrides ++ paramOverrides;

in python.withPackages
   (fix' (pkgs.lib.fold
            extends
            generated
            allOverrides
         )
   )