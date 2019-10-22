Return-Path: <mark.hatle@kernel.crashing.org>
Received: from kernel.crashing.org (kernel.crashing.org [76.164.61.194])
	by mail.openembedded.org (Postfix) with ESMTP id 2DE737F68E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Oct 2019 17:10:46 +0000 (UTC)
Received: from Marks-MacBook-Pro.local ([76.164.61.198]) (authenticated bits=0)
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id x9MHAcFY014424
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NO); Tue, 22 Oct 2019 12:10:39 -0500
To: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>,
	bitbake-devel@lists.openembedded.org
References: <20191022090408.1368-1-jean-marie.lemetayer@savoirfairelinux.com>
	<20191022090408.1368-3-jean-marie.lemetayer@savoirfairelinux.com>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
Message-ID: <4409c36d-23b9-4ddb-d681-5328f75330dc@kernel.crashing.org>
Date: Tue, 22 Oct 2019 12:10:38 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
	Gecko/20100101 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191022090408.1368-3-jean-marie.lemetayer@savoirfairelinux.com>
Cc: brendan.le.foll@intel.com, paul.eggleton@linux.intel.com,
	rennes@savoirfairelinux.com
Subject: Re: [RFC][PATCH 2/2] fetch2/npm.py: refactor the npm fetcher
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 22 Oct 2019 17:10:47 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 10/22/19 4:04 AM, Jean-Marie LEMETAYER wrote:
> This commit refactors the npm fetcher to improve some points and fix
> others:
> 
>  - The big change is that the fetcher is only fetching the package
>    source and no more the dependencies. Thus the npm fetcher act as the
>    other fetchers e.g git, wget. The dependencies will now be fetched
>    by the npm class.

I don't completely understand this and the associated class, but does it work
with the existing MIRROR and BB_NO_NETWORK/BB_ALLOWED_NETWORKS settings?

My concern is for people in environments that are not allowed to download except
from trusted machines, or on disconnected networks so they have everything on a
local mirror of some sort.

Additionally with the mirroring, it's not unusual for the name of what is
downloaded (as well as where it's downloaded from) to change protocol and
format.  I.e. I'd hope something like:

.*:.*/.* file://my_local/on/disk/mirror

>  - This commit also fixes a lot of issues with the package names (exotic
>    characters, scoped packages) which were badly handled.
> 
>  - The validation files - lockdown.json and npm-shrinkwrap.json - are no
>    longer used by the fetcher. Instead, the downloaded tarball is
>    validated with the 'integrity' and 'shasum' provided in the npm view
>    of the package [1] [2].
> 
>  - The lockdown file had generation issues and is no longer relevant
>    with the latest shrinkwrap files. The shrinkwrap file is now used
>    by the npm class.
> 
> 1: https://docs.npmjs.com/files/package-lock.json#integrity
> 2: https://w3c.github.io/webappsec/specs/subresourceintegrity
> 
> Signed-off-by: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
> ---
>  lib/bb/fetch2/npm.py | 464 +++++++++++++++++++------------------------
>  1 file changed, 200 insertions(+), 264 deletions(-)

I'm also not seeing any test cases for this fetcher.  Since this work isn't well
understood by most of the regular maintainers, I think it's extremely important
that test cases are added during any new changes to ensure that the fetcher is
working properly.

--Mark

> diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
> index 9700e610..ea02c6d2 100644
> --- a/lib/bb/fetch2/npm.py
> +++ b/lib/bb/fetch2/npm.py
> @@ -1,301 +1,237 @@
> +# Copyright (C) 2019 Savoir-Faire Linux
>  #
>  # SPDX-License-Identifier: GPL-2.0-only
>  #
>  """
> -BitBake 'Fetch' NPM implementation
> +BitBake 'Fetch' npm implementation
>  
> -The NPM fetcher is used to retrieve files from the npmjs repository
> +npm fetcher support the SRC_URI with format of:
> +SRC_URI = "npm://some.registry.url;OptionA=xxx;OptionB=xxx;..."
>  
> -Usage in the recipe:
> +Supported SRC_URI options are:
>  
> -    SRC_URI = "npm://registry.npmjs.org/;name=${PN};version=${PV}"
> -    Suported SRC_URI options are:
> +- name
> +   The npm package name. This is a mandatory parameter.
>  
> -    - name
> -    - version
> +- version
> +    The npm package version. This is a mandatory parameter.
>  
> -    npm://registry.npmjs.org/${PN}/-/${PN}-${PV}.tgz  would become npm://registry.npmjs.org;name=${PN};version=${PV}
> -    The fetcher all triggers off the existence of ud.localpath. If that exists and has the ".done" stamp, its assumed the fetch is good/done
> +- downloadfilename
> +    Specifies the filename used when storing the downloaded file.
>  
>  """
>  
> -import os
> -import sys
> -import urllib.request, urllib.parse, urllib.error
> +import base64
>  import json
> -import subprocess
> -import signal
> +import os
> +import re
>  import bb
> -from   bb.fetch2 import FetchMethod
> -from   bb.fetch2 import FetchError
> -from   bb.fetch2 import ChecksumError
> -from   bb.fetch2 import runfetchcmd
> -from   bb.fetch2 import logger
> -from   bb.fetch2 import UnpackError
> -from   bb.fetch2 import ParameterError
> -
> -def subprocess_setup():
> -    # Python installs a SIGPIPE handler by default. This is usually not what
> -    # non-Python subprocesses expect.
> -    # SIGPIPE errors are known issues with gzip/bash
> -    signal.signal(signal.SIGPIPE, signal.SIG_DFL)
> +from bb.fetch2 import ChecksumError
> +from bb.fetch2 import FetchError
> +from bb.fetch2 import MissingParameterError
> +from bb.fetch2 import ParameterError
> +from bb.fetch2 import FetchMethod
> +from bb.fetch2 import URI
> +from bb.fetch2 import check_network_access
> +from bb.fetch2 import logger
> +from bb.fetch2 import runfetchcmd
> +from bb.fetch2.wget import WgetProgressHandler
>  
>  class Npm(FetchMethod):
> -
> -    """Class to fetch urls via 'npm'"""
> -    def init(self, d):
> -        pass
> +    """
> +        Class to fetch a package from a npm registry
> +    """
>  
>      def supports(self, ud, d):
>          """
> -        Check to see if a given url can be fetched with npm
> +            Check if a given url can be fetched with npm
>          """
> -        return ud.type in ['npm']
> -
> -    def debug(self, msg):
> -        logger.debug(1, "NpmFetch: %s", msg)
>  
> -    def clean(self, ud, d):
> -        logger.debug(2, "Calling cleanup %s" % ud.pkgname)
> -        bb.utils.remove(ud.localpath, False)
> -        bb.utils.remove(ud.pkgdatadir, True)
> -        bb.utils.remove(ud.fullmirror, False)
> +        return ud.type in ['npm']
>  
>      def urldata_init(self, ud, d):
>          """
> -        init NPM specific variable within url data
> +            Init npm specific variables within url data
>          """
> -        if 'downloadfilename' in ud.parm:
> -            ud.basename = ud.parm['downloadfilename']
> -        else:
> -            ud.basename = os.path.basename(ud.path)
> -
> -        # can't call it ud.name otherwise fetcher base class will start doing sha1stuff
> -        # TODO: find a way to get an sha1/sha256 manifest of pkg & all deps
> -        ud.pkgname = ud.parm.get("name", None)
> -        if not ud.pkgname:
> -            raise ParameterError("NPM fetcher requires a name parameter", ud.url)
> -        ud.version = ud.parm.get("version", None)
> +
> +        # Get the 'name' parameter
> +        if "name" in ud.parm:
> +            ud.name = ud.parm.get("name")
> +
> +        if not ud.name:
> +            raise MissingParameterError("Parameter 'name' required", ud.url)
> +
> +        # Get the 'version' parameter
> +        if "version" in ud.parm:
> +            ud.version = ud.parm.get("version")
> +
>          if not ud.version:
> -            raise ParameterError("NPM fetcher requires a version parameter", ud.url)
> -        ud.bbnpmmanifest = "%s-%s.deps.json" % (ud.pkgname, ud.version)
> -        ud.bbnpmmanifest = ud.bbnpmmanifest.replace('/', '-')
> -        ud.registry = "http://%s" % (ud.url.replace('npm://', '', 1).split(';'))[0]
> -        prefixdir = "npm/%s" % ud.pkgname
> -        ud.pkgdatadir = d.expand("${DL_DIR}/%s" % prefixdir)
> -        if not os.path.exists(ud.pkgdatadir):
> -            bb.utils.mkdirhier(ud.pkgdatadir)
> -        ud.localpath = d.expand("${DL_DIR}/npm/%s" % ud.bbnpmmanifest)
> -
> -        self.basecmd = d.getVar("FETCHCMD_wget") or "/usr/bin/env wget -O -t 2 -T 30 -nv --passive-ftp --no-check-certificate "
> -        ud.prefixdir = prefixdir
> -
> -        ud.write_tarballs = ((d.getVar("BB_GENERATE_MIRROR_TARBALLS") or "0") != "0")
> -        mirrortarball = 'npm_%s-%s.tar.xz' % (ud.pkgname, ud.version)
> -        mirrortarball = mirrortarball.replace('/', '-')
> -        ud.fullmirror = os.path.join(d.getVar("DL_DIR"), mirrortarball)
> -        ud.mirrortarballs = [mirrortarball]
> +            raise MissingParameterError("Parameter 'version' required", ud.url)
> +
> +        # Get the 'registry' part of the url
> +        ud.registry = ud.url.replace("npm://", "http://", 1).split(";")[0]
> +
> +        # Using the 'downloadfilename' parameter as local filename or the
> +        # npm package name.
> +        if "downloadfilename" in ud.parm:
> +            ud.basename = ud.parm["downloadfilename"]
> +        else:
> +            # Scoped package names (with the @) use the same naming convention
> +            # as the 'npm pack' command.
> +            if ud.name.startswith("@"):
> +                ud.basename = re.sub("/", "-", ud.name[1:])
> +            else:
> +                ud.basename = ud.name
> +            ud.basename += "-" + ud.version + ".tgz"
> +
> +        ud.localfile = d.expand(ud.basename)
> +
> +        ud.basecmd = d.getVar("FETCHCMD_wget")
> +
> +        if not ud.basecmd:
> +            ud.basecmd = "wget"
> +            ud.basecmd += " --tries=2"
> +            ud.basecmd += " --timeout=30"
> +            ud.basecmd += " --passive-ftp"
> +            ud.basecmd += " --no-check-certificate"
> +
> +    @staticmethod
> +    def _run_npm_view(ud, d):
> +        """
> +            Run the 'npm view' command to get informations about a npm package.
> +        """
> +
> +        cmd = "npm view"
> +        cmd += " --json"
> +        cmd += " --registry {}".format(ud.registry)
> +        cmd += " '{}@{}'".format(ud.name, ud.version)
> +
> +        view_string = runfetchcmd(cmd, d)
> +
> +        view = json.loads(view_string)
> +
> +        if isinstance(view, list):
> +            return view[-1]
> +
> +        return view
>  
>      def need_update(self, ud, d):
> +        """
> +            Force a fetch, even if localpath exists?
> +        """
> +
> +        # Note that when using a version which does not exist on the registry
> +        # (like 'version=foo') the local filename will use this version
> +        # string (e.g 'my-package-foo.tgz') but the actual downloaded file
> +        # will be the latest version available on the registry (e.g '1.2.3').
> +        #
> +        # This trick can be useful with devtool / recipetool to automatically
> +        # fetch the latest version, BUT these files (the ones with non-existent
> +        # versions) must be updated every times. To reduce issues due to this
> +        # behavior, only the 'latest' keyword can be used. All the other
> +        # non-existent versions are rejected.
> +
> +        view = self._run_npm_view(ud, d)
> +
> +        if ud.version != view.get("version"):
> +            if ud.version == "latest":
> +                return True
> +            else:
> +                raise ParameterError("Parameter 'version' is invalid", ud.url)
> +
>          if os.path.exists(ud.localpath):
>              return False
> +
>          return True
>  
> -    def _runpack(self, ud, d, pkgfullname: str, quiet=False) -> str:
> +    @staticmethod
> +    def _run_wget(ud, d, cmd):
>          """
> -        Runs npm pack on a full package name.
> -        Returns the filename of the downloaded package
> +            Run the 'wget' command with download progress status
>          """
> -        bb.fetch2.check_network_access(d, pkgfullname, ud.registry)
> -        dldir = d.getVar("DL_DIR")
> -        dldir = os.path.join(dldir, ud.prefixdir)
> -
> -        command = "npm pack {} --registry {}".format(pkgfullname, ud.registry)
> -        logger.debug(2, "Fetching {} using command '{}' in {}".format(pkgfullname, command, dldir))
> -        filename = runfetchcmd(command, d, quiet, workdir=dldir)
> -        return filename.rstrip()
> -
> -    def _unpackdep(self, ud, pkg, data, destdir, dldir, d):
> -        file = data[pkg]['tgz']
> -        logger.debug(2, "file to extract is %s" % file)
> -        if file.endswith('.tgz') or file.endswith('.tar.gz') or file.endswith('.tar.Z'):
> -            cmd = 'tar xz --strip 1 --no-same-owner --warning=no-unknown-keyword -f %s/%s' % (dldir, file)
> -        else:
> -            bb.fatal("NPM package %s downloaded not a tarball!" % file)
> -
> -        # Change to subdir before executing command
> -        if not os.path.exists(destdir):
> -            os.makedirs(destdir)
> -        path = d.getVar('PATH')
> -        if path:
> -            cmd = "PATH=\"%s\" %s" % (path, cmd)
> -        bb.note("Unpacking %s to %s/" % (file, destdir))
> -        ret = subprocess.call(cmd, preexec_fn=subprocess_setup, shell=True, cwd=destdir)
> -
> -        if ret != 0:
> -            raise UnpackError("Unpack command %s failed with return value %s" % (cmd, ret), ud.url)
> -
> -        if 'deps' not in data[pkg]:
> -            return
> -        for dep in data[pkg]['deps']:
> -            self._unpackdep(ud, dep, data[pkg]['deps'], "%s/node_modules/%s" % (destdir, dep), dldir, d)
> -
> -
> -    def unpack(self, ud, destdir, d):
> -        dldir = d.getVar("DL_DIR")
> -        with open("%s/npm/%s" % (dldir, ud.bbnpmmanifest)) as datafile:
> -            workobj = json.load(datafile)
> -        dldir = "%s/%s" % (os.path.dirname(ud.localpath), ud.pkgname)
> -
> -        if 'subdir' in ud.parm:
> -            unpackdir = '%s/%s' % (destdir, ud.parm.get('subdir'))
> -        else:
> -            unpackdir = '%s/npmpkg' % destdir
> -
> -        self._unpackdep(ud, ud.pkgname, workobj, unpackdir, dldir, d)
> -
> -    def _parse_view(self, output):
> -        '''
> -        Parse the output of npm view --json; the last JSON result
> -        is assumed to be the one that we're interested in.
> -        '''
> -        pdata = json.loads(output);
> -        try:
> -            return pdata[-1]
> -        except:
> -            return pdata
> -
> -    def _getdependencies(self, pkg, data, version, d, ud, optional=False, fetchedlist=None):
> -        if fetchedlist is None:
> -            fetchedlist = []
> -        pkgfullname = pkg
> -        if version != '*' and not '/' in version:
> -            pkgfullname += "@'%s'" % version
> -        if pkgfullname in fetchedlist:
> -            return
> -
> -        logger.debug(2, "Calling getdeps on %s" % pkg)
> -        fetchcmd = "npm view %s --json --registry %s" % (pkgfullname, ud.registry)
> -        output = runfetchcmd(fetchcmd, d, True)
> -        pdata = self._parse_view(output)
> -        if not pdata:
> -            raise FetchError("The command '%s' returned no output" % fetchcmd)
> -        if optional:
> -            pkg_os = pdata.get('os', None)
> -            if pkg_os:
> -                if not isinstance(pkg_os, list):
> -                    pkg_os = [pkg_os]
> -                blacklist = False
> -                for item in pkg_os:
> -                    if item.startswith('!'):
> -                        blacklist = True
> -                        break
> -                if (not blacklist and 'linux' not in pkg_os) or '!linux' in pkg_os:
> -                    logger.debug(2, "Skipping %s since it's incompatible with Linux" % pkg)
> -                    return
> -        filename = self._runpack(ud, d, pkgfullname)
> -        data[pkg] = {}
> -        data[pkg]['tgz'] = filename
> -        fetchedlist.append(pkgfullname)
> -
> -        dependencies = pdata.get('dependencies', {})
> -        optionalDependencies = pdata.get('optionalDependencies', {})
> -        dependencies.update(optionalDependencies)
> -        depsfound = {}
> -        optdepsfound = {}
> -        data[pkg]['deps'] = {}
> -        for dep in dependencies:
> -            if dep in optionalDependencies:
> -                optdepsfound[dep] = dependencies[dep]
> -            else:
> -                depsfound[dep] = dependencies[dep]
> -        for dep, version in optdepsfound.items():
> -            self._getdependencies(dep, data[pkg]['deps'], version, d, ud, optional=True, fetchedlist=fetchedlist)
> -        for dep, version in depsfound.items():
> -            self._getdependencies(dep, data[pkg]['deps'], version, d, ud, fetchedlist=fetchedlist)
> -
> -    def _getshrinkeddependencies(self, pkg, data, version, d, ud, lockdown, manifest, toplevel=True):
> -        logger.debug(2, "NPM shrinkwrap file is %s" % data)
> -        if toplevel:
> -            name = data.get('name', None)
> -            if name and name != pkg:
> -                for obj in data.get('dependencies', []):
> -                    if obj == pkg:
> -                        self._getshrinkeddependencies(obj, data['dependencies'][obj], data['dependencies'][obj]['version'], d, ud, lockdown, manifest, False)
> -                        return
> -
> -        pkgnameWithVersion = "{}@{}".format(pkg, version)
> -        logger.debug(2, "Get dependencies for {}".format(pkgnameWithVersion))
> -        filename = self._runpack(ud, d, pkgnameWithVersion)
> -        manifest[pkg] = {}
> -        manifest[pkg]['tgz'] = filename
> -        manifest[pkg]['deps'] = {}
> -
> -        if pkg in lockdown:
> -            sha1_expected = lockdown[pkg][version]
> -            sha1_data = bb.utils.sha1_file("npm/%s/%s" % (ud.pkgname, manifest[pkg]['tgz']))
> -            if sha1_expected != sha1_data:
> -                msg = "\nFile: '%s' has %s checksum %s when %s was expected" % (manifest[pkg]['tgz'], 'sha1', sha1_data, sha1_expected)
> -                raise ChecksumError('Checksum mismatch!%s' % msg)
> -        else:
> -            logger.debug(2, "No lockdown data for %s@%s" % (pkg, version))
>  
> -        if 'dependencies' in data:
> -            for obj in data['dependencies']:
> -                logger.debug(2, "Found dep is %s" % str(obj))
> -                self._getshrinkeddependencies(obj, data['dependencies'][obj], data['dependencies'][obj]['version'], d, ud, lockdown, manifest[pkg]['deps'], False)
> +        progresshandler = WgetProgressHandler(d)
> +
> +        check_network_access(d, cmd, ud.url)
> +
> +        cmd += " --progress=dot"
> +        cmd += " --verbose"
> +
> +        runfetchcmd(cmd, d, log=progresshandler)
> +
> +    @staticmethod
> +    def _check_integrity(integrity, filename):
> +        """
> +            Check the subresource integrity.
> +
> +            https://w3c.github.io/webappsec-subresource-integrity
> +            https://www.w3.org/TR/CSP2/#source-list-syntax
> +        """
> +        algo, value_b64 = integrity.split("-", maxsplit=1)
> +        value_hex = base64.b64decode(value_b64).hex()
> +
> +        if algo == "sha256":
> +            return value_hex == bb.utils.sha256_file(filename)
> +        elif algo == "sha384":
> +            return value_hex == bb.utils.sha384_file(filename)
> +        elif algo == "sha512":
> +            return value_hex == bb.utils.sha512_file(filename)
>  
>      def download(self, ud, d):
> -        """Fetch url"""
> -        jsondepobj = {}
> -        shrinkobj = {}
> -        lockdown = {}
> -
> -        if not os.listdir(ud.pkgdatadir) and os.path.exists(ud.fullmirror):
> -            dest = d.getVar("DL_DIR")
> -            bb.utils.mkdirhier(dest)
> -            runfetchcmd("tar -xJf %s" % (ud.fullmirror), d, workdir=dest)
> -            return
> -
> -        if ud.parm.get("noverify", None) != '1':
> -            shwrf = d.getVar('NPM_SHRINKWRAP')
> -            logger.debug(2, "NPM shrinkwrap file is %s" % shwrf)
> -            if shwrf:
> -                try:
> -                    with open(shwrf) as datafile:
> -                        shrinkobj = json.load(datafile)
> -                except Exception as e:
> -                    raise FetchError('Error loading NPM_SHRINKWRAP file "%s" for %s: %s' % (shwrf, ud.pkgname, str(e)))
> -            elif not ud.ignore_checksums:
> -                logger.warning('Missing shrinkwrap file in NPM_SHRINKWRAP for %s, this will lead to unreliable builds!' % ud.pkgname)
> -            lckdf = d.getVar('NPM_LOCKDOWN')
> -            logger.debug(2, "NPM lockdown file is %s" % lckdf)
> -            if lckdf:
> -                try:
> -                    with open(lckdf) as datafile:
> -                        lockdown = json.load(datafile)
> -                except Exception as e:
> -                    raise FetchError('Error loading NPM_LOCKDOWN file "%s" for %s: %s' % (lckdf, ud.pkgname, str(e)))
> -            elif not ud.ignore_checksums:
> -                logger.warning('Missing lockdown file in NPM_LOCKDOWN for %s, this will lead to unreproducible builds!' % ud.pkgname)
> -
> -        if ('name' not in shrinkobj):
> -            self._getdependencies(ud.pkgname, jsondepobj, ud.version, d, ud)
> -        else:
> -            self._getshrinkeddependencies(ud.pkgname, shrinkobj, ud.version, d, ud, lockdown, jsondepobj)
> -
> -        with open(ud.localpath, 'w') as outfile:
> -            json.dump(jsondepobj, outfile)
> -
> -    def build_mirror_data(self, ud, d):
> -        # Generate a mirror tarball if needed
> -        if ud.write_tarballs and not os.path.exists(ud.fullmirror):
> -            # it's possible that this symlink points to read-only filesystem with PREMIRROR
> -            if os.path.islink(ud.fullmirror):
> -                os.unlink(ud.fullmirror)
> -
> -            dldir = d.getVar("DL_DIR")
> -            logger.info("Creating tarball of npm data")
> -            runfetchcmd("tar -cJf %s npm/%s npm/%s" % (ud.fullmirror, ud.bbnpmmanifest, ud.pkgname), d,
> -                        workdir=dldir)
> -            runfetchcmd("touch %s.done" % (ud.fullmirror), d, workdir=dldir)
> +        """
> +            Fetch url
> +        """
> +
> +        view = self._run_npm_view(ud, d)
> +
> +        uri = URI(view.get("dist", {}).get("tarball"))
> +        integrity = view.get("dist", {}).get("integrity")
> +        shasum = view.get("dist", {}).get("shasum")
> +
> +        # Check if version is valid
> +        if ud.version != view.get("version"):
> +            if ud.version == "latest":
> +                logger.warning("The npm package '{}' is using the latest " \
> +                               "version available. This could lead to " \
> +                               "non-reproducible builds.".format(ud.name))
> +            else:
> +                raise ParameterError("Parameter 'version' is invalid", ud.url)
> +
> +        cmd = ud.basecmd
> +
> +        bb.utils.mkdirhier(os.path.dirname(ud.localpath))
> +        cmd += " --output-document='{}'".format(ud.localpath)
> +
> +        if os.path.exists(ud.localpath):
> +            cmd += " --continue"
> +
> +        cmd += d.expand(" --directory-prefix=${DL_DIR}")
> +        cmd += " '{}'".format(uri)
> +
> +        self._run_wget(ud, d, cmd)
> +
> +        if not os.path.exists(ud.localpath):
> +            raise FetchError("The fetched file does not exist")
> +
> +        if os.path.getsize(ud.localpath) == 0:
> +            os.remove(ud.localpath)
> +            raise FetchError("The fetched file is empty")
> +
> +        if integrity is not None:
> +            if not self._check_integrity(integrity, ud.localpath):
> +                raise ChecksumError("The fetched file integrity mismatch")
> +        elif shasum is not None:
> +            if shasum != bb.utils.sha1_file(ud.localpath):
> +                raise ChecksumError("The fetched file shasum mismatch")
> +
> +    def unpack(self, ud, rootdir, d):
> +        """
> +            Unpack the downloaded archive to rootdir
> +        """
> +
> +        cmd = "tar --extract --gzip"
> +        cmd += " --no-same-owner"
> +        cmd += " --transform 's:^package/:npm/:'"
> +        cmd += " --file='{}'".format(ud.localpath)
> +
> +        runfetchcmd(cmd, d, workdir=rootdir)
> 

