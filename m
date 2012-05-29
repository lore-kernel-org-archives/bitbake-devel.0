Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SZO2u-0000Cs-78
	for bitbake-devel@lists.openembedded.org;
	Tue, 29 May 2012 17:09:16 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 29 May 2012 07:58:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="148989461"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by azsmga001.ch.intel.com with ESMTP; 29 May 2012 07:58:57 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Tue, 29 May 2012 07:58:57 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.133]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.90]) with mapi id
	14.01.0355.002; Tue, 29 May 2012 22:58:55 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Robert Yang <liezhi.yang@windriver.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 2/2] replace os.popen with
	subprocess.Popen
Thread-Index: AQHNNoUxFiFJBoGKBUmdMxvc+OGd8pbg6Q0A
Date: Tue, 29 May 2012 14:58:54 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23BB3A1C@SHSMSX102.ccr.corp.intel.com>
References: <cover.1337515887.git.liezhi.yang@windriver.com>
	<401cf2b62edc824883b8c7084f4f742e0b2d098c.1337515887.git.liezhi.yang@windriver.com>
In-Reply-To: <401cf2b62edc824883b8c7084f4f742e0b2d098c.1337515887.git.liezhi.yang@windriver.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: Kang Kai <Kai.Kang@windriver.com>,
	"Zhenfeng.Zhao@windriver.com" <Zhenfeng.Zhao@windriver.com>
Subject: Re: [PATCH 2/2] replace os.popen with subprocess.Popen
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 29 May 2012 15:09:16 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Robert, be careful. Your patch 094742bed2fc01d55f572da946fcfa7a48521401 has=
 broke Hob.

I am going to assign the bug https://bugzilla.yoctoproject.org/show_bug.cgi=
?id=3D2511 to you and Kai.

The error is:
Traceback (most recent call last):
  File "/home/yocto-build5/poky-contrib/bitbake/lib/bb/ui/crumbs/builder.py=
", line 821, in handler_build_started_cb
    self.build_details_page.show_configurations(self.configuration, self.pa=
rameters)
  File "/home/yocto-build5/poky-contrib/bitbake/lib/bb/ui/crumbs/builddetai=
lspage.py", line 336, in show_configurations
    self.config_tv.show(configurations, params)
  File "/home/yocto-build5/poky-contrib/bitbake/lib/bb/ui/crumbs/builddetai=
lspage.py", line 105, in show
    f.close()
AttributeError: 'str' object has no attribute 'close'

--
Shane

Robert Yang wrote on=A02012-05-20:

> Replace os.popen with subprocess.Popen since the older function would
> fail (more or less) silently if the executed program cannot be found
>=20
> There is a bb.process.run() which will invoke the Popen to run command,
> use it for simplify the code.
>=20
> For the:
> p4file =3D os.popen("%s%s files %s" % (p4cmd, p4opt, depot))
> ...
> for file in p4file:
>     list =3D file.split()
> in bitbake/lib/bb/fetch2/perforce.py, it should be an error in the past,
> since it didn't use readline() to read the pipe, but directly used the
> split() for the pipe. Use the bb.process.run would fix the problem since
> bb.process.run will return strings.
>=20
> More info:
> http://docs.python.org/library/subprocess.html#subprocess-replacements
>=20
> [YOCTO #2075]
>=20
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/fetch2/perforce.py            |   11 ++++++-----
>  bitbake/lib/bb/fetch2/svk.py                 |    4 ++--
>  bitbake/lib/bb/ui/crumbs/builddetailspage.py |    5 +++--
>  bitbake/lib/bb/ui/crumbs/hig.py              |    7 ++++---
>  4 files changed, 15 insertions(+), 12 deletions(-)
> diff --git a/bitbake/lib/bb/fetch2/perforce.py
> b/bitbake/lib/bb/fetch2/perforce.py index 6abf15d..df3a3a3 100644 ---
> a/bitbake/lib/bb/fetch2/perforce.py +++
> b/bitbake/lib/bb/fetch2/perforce.py @@ -91,8 +91,8 @@ class
> Perforce(FetchMethod):
>=20
>          p4cmd =3D data.getVar('FETCHCOMMAND_p4', d, True)
>          logger.debug(1, "Running %s%s changes -m 1 %s", p4cmd, p4opt,
> depot) -        p4file =3D os.popen("%s%s changes -m 1 %s" % (p4cmd,
> p4opt, depot)) -        cset =3D p4file.readline().strip() +      =20
> p4file, errors =3D bb.process.run("%s%s changes -m 1 %s" % (p4cmd, p4opt,
> depot)) +        cset =3D p4file.strip()
>          logger.debug(1, "READ %s", cset)
>          if not cset:
>              return -1
> @@ -155,8 +155,8 @@ class Perforce(FetchMethod):
>          logger.debug(2, "Fetch: creating temporary directory")
>          bb.utils.mkdirhier(data.expand('${WORKDIR}', localdata))
>          data.setVar('TMPBASE', data.expand('${WORKDIR}/oep4.XXXXXX',
> localdata), localdata)
> -        tmppipe =3D os.popen(data.getVar('MKTEMPDIRCMD', localdata,
> True) or "false")
> -        tmpfile =3D tmppipe.readline().strip()
> +        tmpfile, errors =3D bb.process.run(data.getVar('MKTEMPDIRCMD',
> localdata, True) or "false")
> +        tmpfile =3D tmpfile.strip()
>          if not tmpfile:
>              raise FetchError("Fetch: unable to create temporary
> directory.. make sure 'mktemp' is in the PATH.", loc)
>=20
> @@ -169,7 +169,8 @@ class Perforce(FetchMethod):
>          os.chdir(tmpfile)
>          logger.info("Fetch " + loc)
>          logger.info("%s%s files %s", p4cmd, p4opt, depot)
> -        p4file =3D os.popen("%s%s files %s" % (p4cmd, p4opt, depot)) +  =
=20
>     p4file, errors =3D bb.process.run("%s%s files %s" % (p4cmd, p4opt,
> depot)) +        p4file =3D p4file.strip()
>=20
>          if not p4file:
>              raise FetchError("Fetch: unable to get the P4 files from %s"=
 %
> depot, loc)
> diff --git a/bitbake/lib/bb/fetch2/svk.py b/bitbake/lib/bb/fetch2/svk.py
> index 9d34abf..ee3823f 100644
> --- a/bitbake/lib/bb/fetch2/svk.py
> +++ b/bitbake/lib/bb/fetch2/svk.py
> @@ -77,8 +77,8 @@ class Svk(FetchMethod):
>          logger.debug(2, "Fetch: creating temporary directory")
>          bb.utils.mkdirhier(data.expand('${WORKDIR}', localdata))
>          data.setVar('TMPBASE', data.expand('${WORKDIR}/oesvk.XXXXXX',
> localdata), localdata)
> -        tmppipe =3D os.popen(data.getVar('MKTEMPDIRCMD', localdata,
> True) or "false")
> -        tmpfile =3D tmppipe.readline().strip()
> +        tmpfile, errors =3D bb.process.run(data.getVar('MKTEMPDIRCMD',
> localdata, True) or "false")
> +        tmpfile =3D tmpfile.strip()
>          if not tmpfile:
>              logger.error()
>              raise FetchError("Fetch: unable to create temporary
> directory.. make sure 'mktemp' is in the PATH.", loc) diff --git
> a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
> b/bitbake/lib/bb/ui/crumbs/builddetailspage.py index c2d5abc..3ec15d4
> 100755 --- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py +++
> b/bitbake/lib/bb/ui/crumbs/builddetailspage.py @@ -23,6 +23,7 @@
>  import gtk import pango import gobject +import bb.process from
>  bb.ui.crumbs.progressbar import HobProgressBar from
>  bb.ui.crumbs.hobwidget import hic, HobNotebook, HobAltButton,
>  HobWarpCellRendererText from bb.ui.crumbs.runningbuild import
>  RunningBuildTreeView
> @@ -96,9 +97,9 @@ class BuildConfigurationTreeView(gtk.TreeView):
>          for path in src_config_info.layers:
>              import os, os.path
>              if os.path.exists(path):
> -                f =3D os.popen('cd %s; git branch 2>&1 | grep "^* " | tr=
 -d
> "* "' % path)
> +                f, errors =3D bb.process.run('cd %s; git branch 2>&1 | g=
rep
> "^* " | tr -d "* "' % path)
>                  if f:
> -                    branch =3D f.readline().lstrip('\n').rstrip('\n')
> +                    branch =3D f.strip('\n')
>                      vars.append(self.set_vars("Branch:", branch))
>                      f.close()
>                  break
> diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/h=
ig.py
> index 721d145..b3936f8 100644
> --- a/bitbake/lib/bb/ui/crumbs/hig.py
> +++ b/bitbake/lib/bb/ui/crumbs/hig.py
> @@ -25,12 +25,12 @@ import gobject
>  import hashlib import os import re -import subprocess import shlex from
>  bb.ui.crumbs.hobcolor import HobColors from bb.ui.crumbs.hobwidget
>  import hcc, hic, HobViewTable, HobInfoButton, HobButton, HobAltButton,
>  HobIconChecker from bb.ui.crumbs.progressbar import HobProgressBar
>  import bb.ui.crumbs.utils
> +import bb.process
>=20
>  """
>  The following are convenience classes for implementing GNOME HIG
> compliant
> @@ -726,7 +726,8 @@ class DeployImageDialog (CrumbsDialog):
>          self.progress_bar.hide()
>      def popen_read(self, cmd):
> -        return os.popen("%s 2>/dev/null" % cmd).read().strip()
> +        tmpout, errors =3D bb.process.run("%s" % cmd)
> +        return tmpout.strip()
>=20
>      def find_all_usb_devices(self):
>          usb_devs =3D [ os.readlink(u)
> @@ -755,7 +756,7 @@ class DeployImageDialog (CrumbsDialog):
>                  cmdline =3D bb.ui.crumbs.utils.which_terminal()
>                  if cmdline:
>                      cmdline +=3D "\"sudo dd if=3D" + self.image_path + "
> of=3D" + combo_item + "\""
> -                    subprocess.Popen(args=3Dshlex.split(cmdline))
> +                    bb.process.run(shlex.split(cmdline))
>=20
>      def update_progress_bar(self, title, fraction, status=3DNone):
>          self.progress_bar.update(fraction)




