# generated using pypi2nix tool (version: 2.0.2)
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
      name = "amqp-2.5.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/92/1d/433541994a5a69f4ad2fff39746ddbb0bdedb0ea0d85673eb0db68a7edd9/amqp-2.5.2.tar.gz";
        sha256 = "77f1aef9410698d20eaeac5b73a87817365f457a507d82edf292e12cbb83b08d";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."vine"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/celery/py-amqp";
        license = licenses.bsdOriginal;
        description = "Low-level AMQP client for Python (fork of amqplib).";
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
      name = "billiard-3.6.1.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/68/1d/2aea8fbb0b1e1260a8a2e77352de2983d36d7ac01207cf14c2b9c6cc860e/billiard-3.6.1.0.tar.gz";
        sha256 = "b8809c74f648dfe69b973c8e660bcec00603758c9db8ba89d7719f88d5f01f26";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/celery/billiard";
        license = licenses.bsdOriginal;
        description = "Python multiprocessing fork with improvements and bugfixes";
      };
    };

    "celery" = python.mkDerivation {
      name = "celery-4.4.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/b5/50/929ce161882c2f35a91aac02f1c6e8556bbdc2a8b53320fc44fa0b9a0cd4/celery-4.4.0.tar.gz";
        sha256 = "d3363bb5df72d74420986a435449f3c3979285941dff57d5d97ecba352a0e3e2";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
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

    "certifi" = python.mkDerivation {
      name = "certifi-2019.11.28";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/41/bf/9d214a5af07debc6acf7f3f257265618f1db242a3f8e49a9b516f24523a6/certifi-2019.11.28.tar.gz";
        sha256 = "25b64c7da4cd7479594d035c08c2d809eb4aab3a26e5a990ea98cc450c320f1f";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://certifi.io/";
        license = licenses.mpl20;
        description = "Python package for providing Mozilla's CA Bundle.";
      };
    };

    "chardet" = python.mkDerivation {
      name = "chardet-3.0.4";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/fc/bb/a5768c230f9ddb03acc9ef3f0d4a3cf93462473795d18e9535498c8f929d/chardet-3.0.4.tar.gz";
        sha256 = "84ab92ed1c4d4f16916e05906b6b75a6c0fb5db821cc65e70cbd64a3e2a5eaae";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/chardet/chardet";
        license = licenses.lgpl2;
        description = "Universal encoding detector for Python 2 and 3";
      };
    };

    "django" = python.mkDerivation {
      name = "django-2.2.9";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/2c/0d/2aa8e58c791d2aa65658fa26f2b035a9da13a6a34d1b2d991912c8a33729/Django-2.2.9.tar.gz";
        sha256 = "662a1ff78792e3fd77f16f71b1f31149489434de4b62a74895bd5d6534e635a5";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
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
      name = "django-classy-tags-0.9.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/8b/21/a209e260f863bf6fafa97fa38ec709d552abfcf6edb0b73be6d680b43eb0/django-classy-tags-0.9.0.tar.gz";
        sha256 = "38b4546a8053499e2fef7af679a58d7c868298717d645b8b8227acba5fd4bf2b";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."django"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/ojii/django-classy-tags";
        license = licenses.bsdOriginal;
        description = "Class based template tags for Django";
      };
    };

    "django-cms" = python.mkDerivation {
      name = "django-cms-3.7.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/c3/55/bab3217850a3dbed17caf0fac4f9351fc13f25c572534080b7ede78edf5c/django-cms-3.7.1.tar.gz";
        sha256 = "05ea915d490562413428e04acb9ecae604c63b8dc5ed9250d0e9437b1314c996";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."django"
        self."django-classy-tags"
        self."django-formtools"
        self."django-sekizai"
        self."django-treebeard"
        self."djangocms-admin-style"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://www.django-cms.org/";
        license = licenses.bsdOriginal;
        description = "An Advanced Django CMS";
      };
    };

    "django-debug-toolbar" = python.mkDerivation {
      name = "django-debug-toolbar-2.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/23/0f/3567d62be25e3722be719e9915605a00e8b779620a2d53f2469331884629/django-debug-toolbar-2.1.tar.gz";
        sha256 = "24c157bc6c0e1648e0a6587511ecb1b007a00a354ce716950bff2de12693e7a8";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
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
      buildInputs = commonBuildInputs ++ [ ];
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
      name = "django-sekizai-1.0.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/61/7c/a170ca36c4ea4c7c228b379df3da9a2dbec4c28ae3d7149c44990512cb0d/django-sekizai-1.0.0.tar.gz";
        sha256 = "642a3356fe92fe9b5ccc97f320b64edd2cfcb3b2fbb113e8a26dad9a1f3b5e14";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."django"
        self."django-classy-tags"
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
      buildInputs = commonBuildInputs ++ [ ];
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
      name = "djangocms-admin-style-1.4.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/43/4a/85121924727ee789e9f0d4a434e0a8a45db4a9d47d411a4000f77154f73b/djangocms-admin-style-1.4.0.tar.gz";
        sha256 = "0ff3f45ed56e98c92fcabf219377f4165ab20a4cb2d018c1da461b6b85179177";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
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
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."django"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://www.django-rest-framework.org/";
        license = licenses.bsdOriginal;
        description = "Web APIs for Django, made easy.";
      };
    };

    "docutils" = python.mkDerivation {
      name = "docutils-0.16";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/2f/e0/3d435b34abd2d62e8206171892f174b180cd37b09d57b924ca5c2ef2219d/docutils-0.16.tar.gz";
        sha256 = "c2de3a60e9e7d07be26b7f2b00ca0309c207e06c100f9cc2a94931fc75a478fc";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://docutils.sourceforge.net/";
        license = licenses.publicDomain;
        description = "Docutils -- Python Documentation Utilities";
      };
    };

    "entrypoints" = python.mkDerivation {
      name = "entrypoints-0.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/b4/ef/063484f1f9ba3081e920ec9972c96664e2edb9fdc3d8669b0e3b8fc0ad7c/entrypoints-0.3.tar.gz";
        sha256 = "c70dd71abe5a8c85e55e12c19bd91ccfeec11a6e99044204511f9ed547d48451";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [
        self."flit"
      ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/takluyver/entrypoints";
        license = licenses.mit;
        description = "Discover and load entry points from installed packages.";
      };
    };

    "flake8" = python.mkDerivation {
      name = "flake8-3.7.9";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/a5/bb/7e707d8001aca96f15f684b02176ecb0575786f041293f090b44ea04f2d0/flake8-3.7.9.tar.gz";
        sha256 = "45681a117ecc81e870cbf1262835ae4af5e7a8b08e40b944a8a6e6b895914cfb";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."entrypoints"
        self."mccabe"
        self."pycodestyle"
        self."pyflakes"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://gitlab.com/pycqa/flake8";
        license = licenses.mit;
        description = "the modular source code checker: pep8, pyflakes and co";
      };
    };

    "flake8-django" = python.mkDerivation {
      name = "flake8-django-0.0.4";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/18/82/63945ffd14b8c7ae5cacb08b5b2af7be9969bc994fff8edd6e9b03659b6d/flake8-django-0.0.4.tar.gz";
        sha256 = "7329ec2e2b8b194e8109639c534359014c79df4d50b14f4b85b8395edc5d6760";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."flake8"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/rocioar/flake8-django";
        license = licenses.mit;
        description = "Plugin to catch bad style specific to Django Projects";
      };
    };

    "flit" = python.mkDerivation {
      name = "flit-2.2.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/35/87/a92625dc5c81cf1608553b27b5c216bdc1e678ea6738a3a8a69ee2e5fb51/flit-2.2.0.tar.gz";
        sha256 = "a273dc2a5ab1f42f0e02878347d94f5462c42cbe232a5014b6778c9e5975327f";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [
        self."flit-core"
      ];
      propagatedBuildInputs = [
        self."docutils"
        self."flit-core"
        self."pytoml"
        self."requests"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/takluyver/flit";
        license = licenses.bsdOriginal;
        description = "A simple packaging tool for simple packages.";
      };
    };

    "flit-core" = python.mkDerivation {
      name = "flit-core-2.2.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/77/72/5dda5dc417a4e702e0d7e4a77e9802792a0e4a2daec2aeed915ead7db477/flit_core-2.2.0.tar.gz";
        sha256 = "4efb8bffc1a04d8e550e877f0c9acf53109a021cc27c2a89b1b467715dc1d657";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [
        self."intreehooks"
      ];
      propagatedBuildInputs = [
        self."pytoml"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/takluyver/flit";
        license = licenses.bsdOriginal;
        description = "Distribution-building parts of Flit. See flit package for more information";
      };
    };

    "idna" = python.mkDerivation {
      name = "idna-2.8";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/ad/13/eb56951b6f7950cadb579ca166e448ba77f9d24efc03edd7e55fa57d04b7/idna-2.8.tar.gz";
        sha256 = "c357b3f628cf53ae2c4c05627ecc484553142ca23264e593d327bcde5e9c3407";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/kjd/idna";
        license = licenses.bsdOriginal;
        description = "Internationalized Domain Names in Applications (IDNA)";
      };
    };

    "importlib-metadata" = python.mkDerivation {
      name = "importlib-metadata-1.4.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/8c/0e/10e247f40c89ba72b7f2a2104ccf1b65de18f79562ffe11bfb837b711acf/importlib_metadata-1.4.0.tar.gz";
        sha256 = "f17c015735e1a88296994c0697ecea7e11db24290941983b08c9feb30921e6d8";
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

    "intreehooks" = python.mkDerivation {
      name = "intreehooks-1.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/f9/a5/5dacebf93232a847970921af2b020f9f2a8e0064e3a97727cd38efc77ba0/intreehooks-1.0.tar.gz";
        sha256 = "87e600d3b16b97ed219c078681260639e77ef5a17c0e0dbdd5a302f99b4e34e1";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."pytoml"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/takluyver/intreehooks";
        license = licenses.mit;
        description = "Load a PEP 517 backend from inside the source tree";
      };
    };

    "kombu" = python.mkDerivation {
      name = "kombu-4.6.7";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/14/98/00cc71801381775fbc6ad17e25d815344a44cdcdda7c0bbccbd92373bb4c/kombu-4.6.7.tar.gz";
        sha256 = "67b32ccb6fea030f8799f8fd50dd08e03a4b99464ebc4952d71d8747b1a52ad1";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
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
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pycqa/mccabe";
        license = licenses.mit;
        description = "McCabe checker, plugin for flake8";
      };
    };

    "more-itertools" = python.mkDerivation {
      name = "more-itertools-8.1.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/df/8c/c278395367a46c00d28036143fdc6583db8f98622b83875403f16473509b/more-itertools-8.1.0.tar.gz";
        sha256 = "c468adec578380b6281a114cb8a5db34eb1116277da92d7c46f904f0b52d3288";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/erikrose/more-itertools";
        license = licenses.mit;
        description = "More routines for operating on iterables, beyond itertools";
      };
    };

    "packaging" = python.mkDerivation {
      name = "packaging-20.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/c7/cf/d84b72480a556d9bd4a191a91b0a8ea71cb48e6f6132f12d9d365c51bdb6/packaging-20.0.tar.gz";
        sha256 = "fe1d8331dfa7cc0a883b49d75fc76380b2ab2734b220fbb87d774e4fd4b851f8";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
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
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://py.readthedocs.io/";
        license = licenses.mit;
        description = "library with cross-python path, ini-parsing, io, code, log facilities";
      };
    };

    "pycodestyle" = python.mkDerivation {
      name = "pycodestyle-2.5.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/1c/d1/41294da5915f4cae7f4b388cea6c2cd0d6cd53039788635f6875dfe8c72f/pycodestyle-2.5.0.tar.gz";
        sha256 = "e40a936c9a450ad81df37f549d676d127b1b66000a6c500caa2b085bc0ca976c";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pycodestyle.readthedocs.io/";
        license = licenses.mit;
        description = "Python style guide checker";
      };
    };

    "pyflakes" = python.mkDerivation {
      name = "pyflakes-2.1.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/52/64/87303747635c2988fcaef18af54bfdec925b6ea3b80bcd28aaca5ba41c9e/pyflakes-2.1.1.tar.gz";
        sha256 = "d976835886f8c5b31d47970ed689944a0262b5f3afa00a5a7b4dc81e5449f8a2";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/PyCQA/pyflakes";
        license = licenses.mit;
        description = "passive checker of Python programs";
      };
    };

    "pyparsing" = python.mkDerivation {
      name = "pyparsing-2.4.6";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/a2/56/0404c03c83cfcca229071d3c921d7d79ed385060bbe969fde3fd8f774ebd/pyparsing-2.4.6.tar.gz";
        sha256 = "4c830582a84fb022400b85429791bc551f1f4871c33f23e44f353119e92f969f";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pyparsing/pyparsing/";
        license = licenses.mit;
        description = "Python parsing module";
      };
    };

    "pytest" = python.mkDerivation {
      name = "pytest-5.3.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/eb/3d/19bac795b6e60f4d6127227d4e11c31f8d9555de5e1f1a5e01ebad1d2ccf/pytest-5.3.3.tar.gz";
        sha256 = "f5d3d0e07333119fe7d4af4ce122362dc4053cdd34a71d2766290cf5369c64ad";
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
      name = "pytest-django-3.8.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/c1/99/b415985195a7d850dbf6a0227d55dde98f261c280df191b1c689f1123018/pytest-django-3.8.0.tar.gz";
        sha256 = "489b904f695f9fb880ce591cf5a4979880afb467763b1f180c07574554bdfd26";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
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

    "pytoml" = python.mkDerivation {
      name = "pytoml-0.1.21";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/f4/ba/98ee2054a2d7b8bebd367d442e089489250b6dc2aee558b000e961467212/pytoml-0.1.21.tar.gz";
        sha256 = "8eecf7c8d0adcff3b375b09fe403407aa9b645c499e5ab8cac670ac4a35f61e7";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/avakar/pytoml";
        license = licenses.mit;
        description = "A parser for TOML-0.4.0";
      };
    };

    "pytz" = python.mkDerivation {
      name = "pytz-2019.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/82/c3/534ddba230bd4fbbd3b7a3d35f3341d014cca213f369a9940925e7e5f691/pytz-2019.3.tar.gz";
        sha256 = "b02c06db6cf09c12dd25137e563b31700d3b80fcc4ad23abb7a315f2789819be";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pythonhosted.org/pytz";
        license = licenses.mit;
        description = "World timezone definitions, modern and historical";
      };
    };

    "requests" = python.mkDerivation {
      name = "requests-2.22.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/01/62/ddcf76d1d19885e8579acb1b1df26a852b03472c0e46d2b959a714c90608/requests-2.22.0.tar.gz";
        sha256 = "11e007a8a2aa0323f5a921e9e6a2d7e4e67d9877e85773fba9ba6419025cbeb4";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."certifi"
        self."chardet"
        self."idna"
        self."urllib3"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://python-requests.org";
        license = licenses.asl20;
        description = "Python HTTP for Humans.";
      };
    };

    "setuptools" = python.mkDerivation {
      name = "setuptools-45.0.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/fd/76/3c7f726ed5c582019937f178d7478ce62716b7e8263344f1684cbe11ab3e/setuptools-45.0.0.zip";
        sha256 = "c46d9c8f2289535457d36c676b541ca78f7dcb736b97d02f50d17f7f15b583cc";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pypa/setuptools";
        license = licenses.mit;
        description = "Easily download, build, install, upgrade, and uninstall Python packages";
      };
    };

    "setuptools-scm" = python.mkDerivation {
      name = "setuptools-scm-3.4.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/9a/29/d8f9b0ddb3b9cb9da4de7fdd5f85bc598f774f22161cf72e5fe47207c8ea/setuptools_scm-3.4.1.tar.gz";
        sha256 = "6aaa6fbeb81d0899d6f473b0d79efccdd9a28f33192f479d5d2bd92b8eb75090";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [
        self."setuptools"
        self."wheel"
      ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pypa/setuptools_scm/";
        license = licenses.mit;
        description = "the blessed package to manage your versions by scm tags";
      };
    };

    "six" = python.mkDerivation {
      name = "six-1.14.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/21/9f/b251f7f8a76dec1d6651be194dfba8fb8d7781d10ab3987190de8391d08e/six-1.14.0.tar.gz";
        sha256 = "236bdbdce46e6e6a3d61a337c0f8b763ca1e8717c03b369e87a7ec7ce1319c0a";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/benjaminp/six";
        license = licenses.mit;
        description = "Python 2 and 3 compatibility utilities";
      };
    };

    "sqlparse" = python.mkDerivation {
      name = "sqlparse-0.3.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/63/c8/229dfd2d18663b375975d953e2bdc06d0eed714f93dcb7732f39e349c438/sqlparse-0.3.0.tar.gz";
        sha256 = "7c3dca29c022744e95b547e867cee89f4fce4373f3549ccd8797d8eb52cdb873";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/andialbrecht/sqlparse";
        license = licenses.bsdOriginal;
        description = "Non-validating SQL parser";
      };
    };

    "urllib3" = python.mkDerivation {
      name = "urllib3-1.25.7";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/ad/fc/54d62fa4fc6e675678f9519e677dfc29b8964278d75333cf142892caf015/urllib3-1.25.7.tar.gz";
        sha256 = "f3c5fd51747d450d4dcf6f923c81f78f811aab8205fda64b0aba34a4e48b0745";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://urllib3.readthedocs.io/";
        license = licenses.mit;
        description = "HTTP library with thread-safe connection pooling, file post, and more.";
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
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/celery/vine";
        license = licenses.bsdOriginal;
        description = "Promises, promises, promises.";
      };
    };

    "wcwidth" = python.mkDerivation {
      name = "wcwidth-0.1.8";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/5e/33/92333eb80be0c96385dee338f30b53e24a8b415d5785e225d789b3f90feb/wcwidth-0.1.8.tar.gz";
        sha256 = "f28b3e8a6483e5d49e7f8949ac1a78314e740333ae305b4ba5defd3e74fb37a8";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/jquast/wcwidth";
        license = licenses.mit;
        description = "Measures number of Terminal column cells of wide-character codes";
      };
    };

    "wheel" = python.mkDerivation {
      name = "wheel-0.33.6";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/59/b0/11710a598e1e148fb7cbf9220fd2a0b82c98e94efbdecb299cb25e7f0b39/wheel-0.33.6.tar.gz";
        sha256 = "10c9da68765315ed98850f8e048347c3eb06dd81822dc2ab1d4fde9dc9702646";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pypa/wheel";
        license = licenses.mit;
        description = "A built-package format for Python.";
      };
    };

    "zipp" = python.mkDerivation {
      name = "zipp-1.0.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/d4/cd/ef86396dce8910413b6ca1ef31ec09367c47e15fc1a12def2cc8ae134dea/zipp-1.0.0.tar.gz";
        sha256 = "d38fbe01bbf7a3593a32bc35a9c4453c32bc42b98c377f9bff7e9f8da157786c";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [
        self."setuptools"
        self."setuptools-scm"
        self."wheel"
      ];
      propagatedBuildInputs = [
        self."more-itertools"
      ];
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
        (import ../overrides.nix { inherit pkgs python ; })
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