Return-Path: <ross.burton@intel.com>
Received: from mail-it0-f43.google.com (mail-it0-f43.google.com
	[209.85.214.43])
	by mail.openembedded.org (Postfix) with ESMTP id 800407743F
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  3 Jun 2016 09:48:10 +0000 (UTC)
Received: by mail-it0-f43.google.com with SMTP id f67so4934908ith.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Jun 2016 02:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=nqcxmLvRIlozWjNCbDHsVgrzBGkns9UUBiQpg/XQep4=;
	b=bSk3j63rb1ghgPZNkqEJUVZyal7MkojziNJHrgTIbXP87G7daJkxvXkfiVwSpKK1qz
	hYeEQpRH//Uk2ac+ufB1DBfiguQ4ga677KxLgEngCZ0tW1WhcWmd4wKSBl/u6NbFDmpf
	JY/cTlUcCyS6CtFLA9WvPG6TjResrT3C+RF9q7jMITSyktErAfHeuvJkA8FmbdoCwgNS
	5JxVjg8yHRkMucQv6dIHZDeluHG7xEZdIWwix06vwm8pJ3LDdJjkr6IzH+MFQRjtTCeT
	A/M/il+h3Iv0NKdsvnryfd0Bt1a0anvZwP3KOORHXzKbN2Qka39ZpQtKmNX8pCWnv8mT
	MXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=nqcxmLvRIlozWjNCbDHsVgrzBGkns9UUBiQpg/XQep4=;
	b=EzhAb1yK2b1KgO7nEwBv86K41D19jOpW2nQl1eNIyQCNtFH1bXxoiJslkCCWum1Zm6
	5MEG0eMjLoiIIgvNi7rsdrjZoIU6JcfBlsjKuvMgTsP+f2CR+QPdjXIrjkfQ6TKrsYnq
	sxwgR/lsHcAXrmJzFxypfdUI2GpPJVgof5nPTpfjtXwwUdPlqoKsKVSf7iD2Z4iguAvi
	ZtX/Zgr6W1yLRZBs04SRU1EOFrRx/WtsBUZ2FSgvXLvQzlIr+kmufZzxlLswWsg001Ii
	JSsMpB4ClkUOWdIQ00EPxk0F4munM3WDVe4wnTixQQyRlrRxb1yV9yrhZbyBd3KG+s0S
	K4lw==
X-Gm-Message-State: ALyK8tLaCht93VPh35RuvI3yyxNad96GpunzGWt9xzdTl+16LmkRoM0N5i7GRlIQ47J6zdAyOHM9sNRarHyBd2jM
X-Received: by 10.36.17.134 with SMTP id 128mr3534928itf.83.1464947290848;
	Fri, 03 Jun 2016 02:48:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.162.6 with HTTP; Fri, 3 Jun 2016 02:47:51 -0700 (PDT)
In-Reply-To: <1464205704-26377-2-git-send-email-andrew@bradfordembedded.com>
References: <1464205704-26377-1-git-send-email-andrew@bradfordembedded.com>
	<1464205704-26377-2-git-send-email-andrew@bradfordembedded.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Fri, 3 Jun 2016 10:47:51 +0100
Message-ID: <CAJTo0LbvONwNTroCJrJ8K1MP1zJ_98g-NrWw7SbNfeOp94nQGA@mail.gmail.com>
To: Andrew Bradford <andrew@bradfordembedded.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Andrew Bradford <andrew.bradford@kodakalaris.com>
Subject: Re: [PATCH 1/2] perforce fetcher: Rework to support SRCREV and P4CONFIG
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
X-List-Received-Date: Fri, 03 Jun 2016 09:48:12 -0000
Content-Type: multipart/alternative; boundary=001a1143f53ae2fea705345c9ebf

--001a1143f53ae2fea705345c9ebf
Content-Type: text/plain; charset=UTF-8

Master has just landed the Python3 port, so can you rebase this to current
git master?

Thanks,
Ross

On 25 May 2016 at 20:48, Andrew Bradford <andrew@bradfordembedded.com>
wrote:

> From: Andrew Bradford <andrew.bradford@kodakalaris.com>
>
> In recipes which use the perforce fetcher, enable use of SRCREV to
> specify any of: ${AUTOREV}, changeset number, p4date, or label.  This is
> more in-line with how the other fetchers work for source control
> systems.
>
> Allow use of the P4CONFIG env variable to define the server URL,
> username, and password if not provided in a recipe.
>
> This does change existing perforce fetcher usage by recipes and will
> need those recipes which use the perforce fetcher to be updated.  No
> recipes in oe-core use the perforce fetcher.
>
> References [YOCTO #6303]
>
> Signed-off-by: Andrew Bradford <andrew.bradford@kodakalaris.com>
> ---
>  lib/bb/fetch2/__init__.py |   3 +-
>  lib/bb/fetch2/perforce.py | 279
> ++++++++++++++++++++++++----------------------
>  2 files changed, 147 insertions(+), 135 deletions(-)
>
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 7d2f350..b6e9f9a 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -809,7 +809,8 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None):
>                    'GIT_SMART_HTTP',
>                    'SSH_AUTH_SOCK', 'SSH_AGENT_PID',
>                    'SOCKS5_USER', 'SOCKS5_PASSWD',
> -                  'DBUS_SESSION_BUS_ADDRESS']
> +                  'DBUS_SESSION_BUS_ADDRESS',
> +                  'P4CONFIG']
>
>      if not cleanup:
>          cleanup = []
> diff --git a/lib/bb/fetch2/perforce.py b/lib/bb/fetch2/perforce.py
> index 3a10c7c..b84489a 100644
> --- a/lib/bb/fetch2/perforce.py
> +++ b/lib/bb/fetch2/perforce.py
> @@ -1,14 +1,12 @@
>  # ex:ts=4:sw=4:sts=4:et
>  # -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
>  """
> -BitBake 'Fetch' implementations
> -
> -Classes for obtaining upstream sources for the
> -BitBake build tools.
> +BitBake 'Fetch' implementation for perforce
>
>  """
>
>  # Copyright (C) 2003, 2004  Chris Larson
> +# Copyright (C) 2016 Kodak Alaris, Inc.
>  #
>  # This program is free software; you can redistribute it and/or modify
>  # it under the terms of the GNU General Public License version 2 as
> @@ -25,9 +23,8 @@ BitBake build tools.
>  #
>  # Based on functions from the base bb module, Copyright 2003 Holger
> Schurig
>
> -from future_builtins import zip
>  import os
> -import subprocess
> +import sys
>  import logging
>  import bb
>  from   bb import data
> @@ -37,151 +34,165 @@ from   bb.fetch2 import logger
>  from   bb.fetch2 import runfetchcmd
>
>  class Perforce(FetchMethod):
> +    """ Class to fetch from perforce repositories """
>      def supports(self, ud, d):
> +        """ Check to see if a given url can be fetched with perforce. """
>          return ud.type in ['p4']
>
> -    def doparse(url, d):
> -        parm = {}
> -        path = url.split("://")[1]
> +    def urldata_init(self, ud, d):
> +        """
> +        Initialize perforce specific variables within url data.  If
> P4PORT is
> +        not provided by the recipe but P4CONFIG is provided by the env,
> let
> +        perforce use P4CONFIG as it naturally does to set P4USER,
> P4PASSWD, and
> +        P4PORT.
> +        """
> +        ud.basecmd = d.getVar('FETCHCMD_p4', True)
> +        ud.usingp4config = False
> +
> +        path = ud.url.split("://")[1]
> +        path = path.split(";")[0]
>          delim = path.find("@");
>          if delim != -1:
> -            (user, pswd, host, port) = path.split('@')[0].split(":")
> -            path = path.split('@')[1]
> +            (ud.user, ud.pswd) = path.split('@')[0].split(":")
> +            ud.path = path.split('@')[1]
>          else:
> -            (host, port) = d.getVar('P4PORT', False).split(':')
> -            user = ""
> -            pswd = ""
> -
> -        if path.find(";") != -1:
> -            keys=[]
> -            values=[]
> -            plist = path.split(';')
> -            for item in plist:
> -                if item.count('='):
> -                    (key, value) = item.split('=')
> -                    keys.append(key)
> -                    values.append(value)
> -
> -            parm = dict(zip(keys, values))
> -        path = "//" + path.split(';')[0]
> -        host += ":%s" % (port)
> -        parm["cset"] = Perforce.getcset(d, path, host, user, pswd, parm)
> -
> -        return host, path, user, pswd, parm
> -    doparse = staticmethod(doparse)
> -
> -    def getcset(d, depot, host, user, pswd, parm):
> -        p4opt = ""
> -        if "cset" in parm:
> -            return parm["cset"];
> -        if user:
> -            p4opt += " -u %s" % (user)
> -        if pswd:
> -            p4opt += " -P %s" % (pswd)
> -        if host:
> -            p4opt += " -p %s" % (host)
> -
> -        p4date = d.getVar("P4DATE", True)
> -        if "revision" in parm:
> -            depot += "#%s" % (parm["revision"])
> -        elif "label" in parm:
> -            depot += "@%s" % (parm["label"])
> -        elif p4date:
> -            depot += "@%s" % (p4date)
> -
> -        p4cmd = d.getVar('FETCHCMD_p4', True) or "p4"
> -        logger.debug(1, "Running %s%s changes -m 1 %s", p4cmd, p4opt,
> depot)
> -        p4file, errors = bb.process.run("%s%s changes -m 1 %s" % (p4cmd,
> p4opt, depot))
> -        cset = p4file.strip()
> -        logger.debug(1, "READ %s", cset)
> -        if not cset:
> -            return -1
> -
> -        return cset.split(' ')[1]
> -    getcset = staticmethod(getcset)
> -
> -    def urldata_init(self, ud, d):
> -        (host, path, user, pswd, parm) = Perforce.doparse(ud.url, d)
> +            ud.path = path
>
> -        base_path = path.replace('/...', '')
> -        base_path = self._strip_leading_slashes(base_path)
> -
> -        if "label" in parm:
> -            version = parm["label"]
> +        p4port = d.getVar('P4PORT', True)
> +        if p4port:
> +            ud.host = p4port
>          else:
> -            version = Perforce.getcset(d, path, host, user, pswd, parm)
> -
> -        ud.localfile = data.expand('%s+%s+%s.tar.gz' % (host,
> base_path.replace('/', '.'), version), d)
> -
> -    def download(self, ud, d):
> +            p4config = d.getVar('P4CONFIG', True)
> +            if p4config:
> +                logger.info("Using P4CONFIG to specify P4PORT")
> +                ud.usingp4config = True
> +                ud.host, errors = bb.process.run("p4 info | grep \"Server
> address\"")
> +                ud.host = ud.host.split(': ')[1].strip()
> +                logger.info("Determined P4PORT to be: %s" % ud.host)
> +                if not ud.host:
> +                    raise FetchError("Could not determine server name
> from P4CONFIG")
> +            else:
> +                raise FetchError("SRC_URI is not valid, did you forget to
> specify P4PORT or P4CONFIG?")
> +
> +        relpath = ud.path.replace('/...', '')
> +        relpath = self._strip_leading_slashes(relpath)
> +        relpath = relpath.replace('/', '.')
> +        cleanedhost = ud.host.replace(':', '.')
> +        ud.pkgdir = os.path.join(data.expand('${P4DIR}', d), cleanedhost,
> relpath)
> +
> +        ud.setup_revisons(d)
> +
> +        ud.localfile = data.expand('%s_%s_%s.tar.gz' % (cleanedhost,
> relpath, ud.revision), d)
> +
> +    def _buildp4command(self, ud, d, command, depot_filename=None):
>          """
> -        Fetch urls
> +        Build a p4 commandline.  Valid commands are "changes", "print",
> and
> +        "files".  depot_filename is the full path to the file in the depot
> +        including the trailing '#rev' value.
>          """
> -
> -        (host, depot, user, pswd, parm) = Perforce.doparse(ud.url, d)
> -
> -        if depot.find('/...') != -1:
> -            path = depot[:depot.find('/...')]
> -        else:
> -            path = depot[:depot.rfind('/')]
> -
> -        module = parm.get('module', os.path.basename(path))
> -
> -        # Get the p4 command
>          p4opt = ""
> -        if user:
> -            p4opt += " -u %s" % (user)
> -
> -        if pswd:
> -            p4opt += " -P %s" % (pswd)
> -
> -        if host:
> -            p4opt += " -p %s" % (host)
> -
> -        p4cmd = d.getVar('FETCHCMD_p4', True) or "p4"
> -
> -        # create temp directory
> -        logger.debug(2, "Fetch: creating temporary directory")
> -        bb.utils.mkdirhier(d.expand('${WORKDIR}'))
> -        mktemp = d.getVar("FETCHCMD_p4mktemp", True) or d.expand("mktemp
> -d -q '${WORKDIR}/oep4.XXXXXX'")
> -        tmpfile, errors = bb.process.run(mktemp)
> -        tmpfile = tmpfile.strip()
> -        if not tmpfile:
> -            raise FetchError("Fetch: unable to create temporary
> directory.. make sure 'mktemp' is in the PATH.", ud.url)
> -
> -        if "label" in parm:
> -            depot = "%s@%s" % (depot, parm["label"])
> +        if ud.user:
> +            p4opt += " -u \"%s\"" % (ud.user)
> +        if ud.pswd:
> +            p4opt += " -P \"%s\"" % (ud.pswd)
> +        if ud.host and not ud.usingp4config:
> +            p4opt += " -p %s" % (ud.host)
> +        if hasattr(ud, 'revision') and ud.revision:
> +                pathnrev = "%s@%s" % (ud.path, ud.revision)
>          else:
> -            cset = Perforce.getcset(d, depot, host, user, pswd, parm)
> -            depot = "%s@%s" % (depot, cset)
> -
> -        os.chdir(tmpfile)
> -        logger.info("Fetch " + ud.url)
> -        logger.info("%s%s files %s", p4cmd, p4opt, depot)
> -        p4file, errors = bb.process.run("%s%s files %s" % (p4cmd, p4opt,
> depot))
> -        p4file = [f.rstrip() for f in p4file.splitlines()]
> +            pathnrev = "%s" % (ud.path)
> +
> +        if depot_filename:
> +            # FIXME: handle when SRC_URI is a single file and not a dir
> +            filename = depot_filename[len(ud.path)-1:] # Remove leading
> path
> +            where = filename.find("#") # Remove trailing '#rev'
> +            filename = filename[:where]
> +
> +        if command == "changes":
> +            p4cmd = "%s%s changes -m 1 //%s" % (ud.basecmd, p4opt,
> pathnrev)
> +        elif command == "print":
> +            if depot_filename != None:
> +                p4cmd = "%s%s print -o \"p4/%s\" \"%s\"" % (ud.basecmd,
> p4opt, filename, depot_filename)
> +            else:
> +                raise FetchError("No depot file name provided to p4 %s" %
> command, ud.url)
> +        elif command == "files":
> +            p4cmd = "%s%s files //%s" % (ud.basecmd, p4opt, pathnrev)
> +        else:
> +            raise FetchError("Invalid p4 command %s" % command, ud.url)
>
> -        if not p4file:
> -            raise FetchError("Fetch: unable to get the P4 files from %s"
> % depot, ud.url)
> +        return p4cmd
>
> +    def _p4listfiles(self, ud, d):
> +        """
> +        Return a list of the file names which are present in the depot
> using the
> +        'p4 files' command, including trailing '#rev' file revision
> indicator
> +        """
> +        p4cmd = self._buildp4command(ud, d, "files")
> +        bb.fetch2.check_network_access(d, p4cmd)
> +        p4fileslist = runfetchcmd(p4cmd, d, True)
> +        p4fileslist = [f.rstrip() for f in p4fileslist.splitlines()]
> +        if not p4fileslist:
> +            raise FetchError("Unable to fetch listing of p4 files from %s@%s"
> % ud.host, ud.path)
>          count = 0
> -
> -        for file in p4file:
> -            list = file.split()
> -
> -            if list[2] == "delete":
> +        filelist = []
> +        for filename in p4fileslist:
> +            item = filename.split(" - ")
> +            lastaction = item[1].split()
> +            logger.info("File: " + item[0] + " Last Action: " +
> lastaction[0])
> +            if lastaction[0] == "delete":
>                  continue
> +            filelist.append(item[0])
>
> -            dest = list[0][len(path)+1:]
> -            where = dest.find("#")
> +        return filelist
>
> -            subprocess.call("%s%s print -o %s/%s %s" % (p4cmd, p4opt,
> module, dest[:where], list[0]), shell=True)
> -            count = count + 1
> +    def download(self, ud, d):
> +        """ Get the list of files, fetch each one """
> +        filelist = self._p4listfiles(ud, d)
> +
> +        if not filelist:
> +            raise FetchError("No files found in depot %s@%s" % ud.host,
> ud.path)
>
> -        if count == 0:
> -            logger.error()
> -            raise FetchError("Fetch: No files gathered from the P4
> fetch", ud.url)
> +        logger.info("Fetch " + ud.url)
> +        bb.utils.remove(ud.pkgdir, True)
> +        bb.utils.mkdirhier(ud.pkgdir)
> +        os.chdir(ud.pkgdir)
> +
> +        for afile in filelist:
> +            p4fetchcmd = self._buildp4command(ud, d, "print", afile)
> +            logger.debug(1, "Running %s", p4fetchcmd)
> +            bb.fetch2.check_network_access(d, p4fetchcmd)
> +            runfetchcmd(p4fetchcmd, d)
> +
> +        os.chdir(ud.pkgdir)
> +        runfetchcmd("tar -czf %s p4" % (ud.localpath), d, cleanup =
> [ud.localpath])
> +
> +    def clean(self, ud, d):
> +        """ Cleanup p4 specific files and dirs"""
> +        bb.utils.remove(ud.localpath)
> +        bb.utils.remove(ud.pkgdir, True)
> +
> +    def supports_srcrev(self):
> +        return True
> +
> +    def _revision_key(self, ud, d, name):
> +        """ Return a unique key for the url """
> +        return "p4:" + ud.pkgdir
> +
> +    def _latest_revision(self, ud, d, name):
> +        """ Return the latest upstream scm revision number """
> +        p4cmd = self._buildp4command(ud, d, "changes")
> +        bb.fetch2.check_network_access(d, p4cmd)
> +        tip = runfetchcmd(p4cmd, d, True)
> +        if not tip:
> +            raise FetchError("Could not determine the latest perforce
> changeset")
> +        tipcset = tip.split(' ')[1]
> +        logger.debug(1, "p4 tip found to be changeset %s", tipcset)
> +        return tipcset
> +
> +    def sortable_revision(self, ud, d, name):
> +        """ Return a sortable revision number """
> +        return False, self._build_revision(ud, d)
> +
> +    def _build_revision(self, ud, d):
> +        return ud.revision
>
> -        runfetchcmd("tar -czf %s %s" % (ud.localpath, module), d, cleanup
> = [ud.localpath])
> -        # cleanup
> -        bb.utils.prunedir(tmpfile)
> --
> 2.8.1
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--001a1143f53ae2fea705345c9ebf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Master has just landed the Python3 port, so can you rebase=
 this to current git master?<div><br></div><div>Thanks,</div><div>Ross</div=
></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On 25 May =
2016 at 20:48, Andrew Bradford <span dir=3D"ltr">&lt;<a href=3D"mailto:andr=
ew@bradfordembedded.com" target=3D"_blank">andrew@bradfordembedded.com</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: Andrew Bradford &=
lt;<a href=3D"mailto:andrew.bradford@kodakalaris.com">andrew.bradford@kodak=
alaris.com</a>&gt;<br>
<br>
In recipes which use the perforce fetcher, enable use of SRCREV to<br>
specify any of: ${AUTOREV}, changeset number, p4date, or label.=C2=A0 This =
is<br>
more in-line with how the other fetchers work for source control<br>
systems.<br>
<br>
Allow use of the P4CONFIG env variable to define the server URL,<br>
username, and password if not provided in a recipe.<br>
<br>
This does change existing perforce fetcher usage by recipes and will<br>
need those recipes which use the perforce fetcher to be updated.=C2=A0 No<b=
r>
recipes in oe-core use the perforce fetcher.<br>
<br>
References [YOCTO #6303]<br>
<br>
Signed-off-by: Andrew Bradford &lt;<a href=3D"mailto:andrew.bradford@kodaka=
laris.com">andrew.bradford@kodakalaris.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/fetch2/__init__.py |=C2=A0 =C2=A03 +-<br>
=C2=A0lib/bb/fetch2/perforce.py | 279 ++++++++++++++++++++++++-------------=
---------<br>
=C2=A02 files changed, 147 insertions(+), 135 deletions(-)<br>
<br>
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py<br>
index 7d2f350..b6e9f9a 100644<br>
--- a/lib/bb/fetch2/__init__.py<br>
+++ b/lib/bb/fetch2/__init__.py<br>
@@ -809,7 +809,8 @@ def runfetchcmd(cmd, d, quiet=3DFalse, cleanup=3DNone):=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;G=
IT_SMART_HTTP&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;S=
SH_AUTH_SOCK&#39;, &#39;SSH_AGENT_PID&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;S=
OCKS5_USER&#39;, &#39;SOCKS5_PASSWD&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;DBUS_S=
ESSION_BUS_ADDRESS&#39;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;DBUS_S=
ESSION_BUS_ADDRESS&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;P4CONF=
IG&#39;]<br>
<br>
=C2=A0 =C2=A0 =C2=A0if not cleanup:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cleanup =3D []<br>
diff --git a/lib/bb/fetch2/perforce.py b/lib/bb/fetch2/perforce.py<br>
index 3a10c7c..b84489a 100644<br>
--- a/lib/bb/fetch2/perforce.py<br>
+++ b/lib/bb/fetch2/perforce.py<br>
@@ -1,14 +1,12 @@<br>
=C2=A0# ex:ts=3D4:sw=3D4:sts=3D4:et<br>
=C2=A0# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-<br>
=C2=A0&quot;&quot;&quot;<br>
-BitBake &#39;Fetch&#39; implementations<br>
-<br>
-Classes for obtaining upstream sources for the<br>
-BitBake build tools.<br>
+BitBake &#39;Fetch&#39; implementation for perforce<br>
<br>
=C2=A0&quot;&quot;&quot;<br>
<br>
=C2=A0# Copyright (C) 2003, 2004=C2=A0 Chris Larson<br>
+# Copyright (C) 2016 Kodak Alaris, Inc.<br>
=C2=A0#<br>
=C2=A0# This program is free software; you can redistribute it and/or modif=
y<br>
=C2=A0# it under the terms of the GNU General Public License version 2 as<b=
r>
@@ -25,9 +23,8 @@ BitBake build tools.<br>
=C2=A0#<br>
=C2=A0# Based on functions from the base bb module, Copyright 2003 Holger S=
churig<br>
<br>
-from future_builtins import zip<br>
=C2=A0import os<br>
-import subprocess<br>
+import sys<br>
=C2=A0import logging<br>
=C2=A0import bb<br>
=C2=A0from=C2=A0 =C2=A0bb import data<br>
@@ -37,151 +34,165 @@ from=C2=A0 =C2=A0bb.fetch2 import logger<br>
=C2=A0from=C2=A0 =C2=A0bb.fetch2 import runfetchcmd<br>
<br>
=C2=A0class Perforce(FetchMethod):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot; Class to fetch from perforce repositories=
 &quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0def supports(self, ud, d):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot; Check to see if a given url=
 can be fetched with perforce. &quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ud.type in [&#39;p4&#39;]<br>
<br>
-=C2=A0 =C2=A0 def doparse(url, d):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 parm =3D {}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 path =3D url.split(&quot;://&quot;)[1]<br>
+=C2=A0 =C2=A0 def urldata_init(self, ud, d):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Initialize perforce specific variables within =
url data.=C2=A0 If P4PORT is<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 not provided by the recipe but P4CONFIG is pro=
vided by the env, let<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 perforce use P4CONFIG as it naturally does to =
set P4USER, P4PASSWD, and<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 P4PORT.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.basecmd =3D d.getVar(&#39;FETCHCMD_p4&#39;,=
 True)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.usingp4config =3D False<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 path =3D ud.url.split(&quot;://&quot;)[1]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 path =3D path.split(&quot;;&quot;)[0]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0delim =3D path.find(&quot;@&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if delim !=3D -1:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (user, pswd, host, port) =3D pat=
h.split(&#39;@&#39;)[0].split(&quot;:&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path =3D path.split(&#39;@&#39;)=
[1]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (ud.user, ud.pswd) =3D path.spli=
t(&#39;@&#39;)[0].split(&quot;:&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.path =3D path.split(&#39;@&#3=
9;)[1]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (host, port) =3D d.getVar(&#39;P=
4PORT&#39;, False).split(&#39;:&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 user =3D &quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pswd =3D &quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if path.find(&quot;;&quot;) !=3D -1:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keys=3D[]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 values=3D[]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 plist =3D path.split(&#39;;&#39;=
)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for item in plist:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if item.count(&#39=
;=3D&#39;):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (key=
, value) =3D item.split(&#39;=3D&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keys=
.append(key)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 valu=
es.append(value)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parm =3D dict(zip(keys, values))=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 path =3D &quot;//&quot; + path.split(&#39;;&#3=
9;)[0]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 host +=3D &quot;:%s&quot; % (port)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 parm[&quot;cset&quot;] =3D Perforce.getcset(d,=
 path, host, user, pswd, parm)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return host, path, user, pswd, parm<br>
-=C2=A0 =C2=A0 doparse =3D staticmethod(doparse)<br>
-<br>
-=C2=A0 =C2=A0 def getcset(d, depot, host, user, pswd, parm):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 p4opt =3D &quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;cset&quot; in parm:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return parm[&quot;cset&quot;];<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if user:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p4opt +=3D &quot; -u %s&quot; % =
(user)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if pswd:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p4opt +=3D &quot; -P %s&quot; % =
(pswd)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if host:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p4opt +=3D &quot; -p %s&quot; % =
(host)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 p4date =3D d.getVar(&quot;P4DATE&quot;, True)<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;revision&quot; in parm:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 depot +=3D &quot;#%s&quot; % (pa=
rm[&quot;revision&quot;])<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif &quot;label&quot; in parm:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 depot +=3D &quot;@%s&quot; % (pa=
rm[&quot;label&quot;])<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif p4date:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 depot +=3D &quot;@%s&quot; % (p4=
date)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 p4cmd =3D d.getVar(&#39;FETCHCMD_p4&#39;, True=
) or &quot;p4&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.debug(1, &quot;Running %s%s changes -m =
1 %s&quot;, p4cmd, p4opt, depot)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 p4file, errors =3D bb.process.run(&quot;%s%s c=
hanges -m 1 %s&quot; % (p4cmd, p4opt, depot))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cset =3D p4file.strip()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.debug(1, &quot;READ %s&quot;, cset)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not cset:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return cset.split(&#39; &#39;)[1]<br>
-=C2=A0 =C2=A0 getcset =3D staticmethod(getcset)<br>
-<br>
-=C2=A0 =C2=A0 def urldata_init(self, ud, d):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 (host, path, user, pswd, parm) =3D Perforce.do=
parse(ud.url, d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.path =3D path<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 base_path =3D path.replace(&#39;/...&#39;, &#3=
9;&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 base_path =3D self._strip_leading_slashes(base=
_path)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;label&quot; in parm:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 version =3D parm[&quot;label&quo=
t;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 p4port =3D d.getVar(&#39;P4PORT&#39;, True)<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if p4port:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.host =3D p4port<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 version =3D Perforce.getcset(d, =
path, host, user, pswd, parm)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.localfile =3D data.expand(&#39;%s+%s+%s.tar=
.gz&#39; % (host, base_path.replace(&#39;/&#39;, &#39;.&#39;), version), d)=
<br>
-<br>
-=C2=A0 =C2=A0 def download(self, ud, d):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p4config =3D d.getVar(&#39;P4CON=
FIG&#39;, True)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if p4config:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://=
logger.info" rel=3D"noreferrer" target=3D"_blank">logger.info</a>(&quot;Usi=
ng P4CONFIG to specify P4PORT&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.usingp4config =
=3D True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.host, errors =
=3D bb.process.run(&quot;p4 info | grep \&quot;Server address\&quot;&quot;)=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.host =3D ud.hos=
t.split(&#39;: &#39;)[1].strip()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://=
logger.info" rel=3D"noreferrer" target=3D"_blank">logger.info</a>(&quot;Det=
ermined P4PORT to be: %s&quot; % ud.host)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not ud.host:<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rais=
e FetchError(&quot;Could not determine server name from P4CONFIG&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise FetchError(&=
quot;SRC_URI is not valid, did you forget to specify P4PORT or P4CONFIG?&qu=
ot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 relpath =3D ud.path.replace(&#39;/...&#39;, &#=
39;&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 relpath =3D self._strip_leading_slashes(relpat=
h)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 relpath =3D relpath.replace(&#39;/&#39;, &#39;=
.&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cleanedhost =3D ud.host.replace(&#39;:&#39;, &=
#39;.&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.pkgdir =3D os.path.join(data.expand(&#39;${=
P4DIR}&#39;, d), cleanedhost, relpath)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.setup_revisons(d)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.localfile =3D data.expand(&#39;%s_%s_%s.tar=
.gz&#39; % (cleanedhost, relpath, ud.revision), d)<br>
+<br>
+=C2=A0 =C2=A0 def _buildp4command(self, ud, d, command, depot_filename=3DN=
one):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Fetch urls<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Build a p4 commandline.=C2=A0 Valid commands a=
re &quot;changes&quot;, &quot;print&quot;, and<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;files&quot;.=C2=A0 depot_filename is the=
 full path to the file in the depot<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 including the trailing &#39;#rev&#39; value.<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 (host, depot, user, pswd, parm) =3D Perforce.d=
oparse(ud.url, d)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if depot.find(&#39;/...&#39;) !=3D -1:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path =3D depot[:depot.find(&#39;=
/...&#39;)]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path =3D depot[:depot.rfind(&#39=
;/&#39;)]<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 module =3D parm.get(&#39;module&#39;, os.path.=
basename(path))<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Get the p4 command<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p4opt =3D &quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if user:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p4opt +=3D &quot; -u %s&quot; % =
(user)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if pswd:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p4opt +=3D &quot; -P %s&quot; % =
(pswd)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if host:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p4opt +=3D &quot; -p %s&quot; % =
(host)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 p4cmd =3D d.getVar(&#39;FETCHCMD_p4&#39;, True=
) or &quot;p4&quot;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # create temp directory<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.debug(2, &quot;Fetch: creating temporar=
y directory&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.utils.mkdirhier(d.expand(&#39;${WORKDIR}&#3=
9;))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 mktemp =3D d.getVar(&quot;FETCHCMD_p4mktemp&qu=
ot;, True) or d.expand(&quot;mktemp -d -q &#39;${WORKDIR}/oep4.XXXXXX&#39;&=
quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tmpfile, errors =3D bb.process.run(mktemp)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tmpfile =3D tmpfile.strip()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not tmpfile:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise FetchError(&quot;Fetch: un=
able to create temporary directory.. make sure &#39;mktemp&#39; is in the P=
ATH.&quot;, ud.url)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;label&quot; in parm:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 depot =3D &quot;%s@%s&quot; % (d=
epot, parm[&quot;label&quot;])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.user:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p4opt +=3D &quot; -u \&quot;%s\&=
quot;&quot; % (ud.user)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.pswd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p4opt +=3D &quot; -P \&quot;%s\&=
quot;&quot; % (ud.pswd)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.host and not ud.usingp4config:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p4opt +=3D &quot; -p %s&quot; % =
(ud.host)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if hasattr(ud, &#39;revision&#39;) and ud.revi=
sion:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pathnrev =3D &quot=
;%s@%s&quot; % (ud.path, ud.revision)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cset =3D Perforce.getcset(d, dep=
ot, host, user, pswd, parm)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 depot =3D &quot;%s@%s&quot; % (d=
epot, cset)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.chdir(tmpfile)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://logger.info" rel=3D"noreferr=
er" target=3D"_blank">logger.info</a>(&quot;Fetch &quot; + ud.url)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://logger.info" rel=3D"noreferr=
er" target=3D"_blank">logger.info</a>(&quot;%s%s files %s&quot;, p4cmd, p4o=
pt, depot)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 p4file, errors =3D bb.process.run(&quot;%s%s f=
iles %s&quot; % (p4cmd, p4opt, depot))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 p4file =3D [f.rstrip() for f in p4file.splitli=
nes()]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pathnrev =3D &quot;%s&quot; % (u=
d.path)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if depot_filename:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # FIXME: handle when SRC_URI is =
a single file and not a dir<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filename =3D depot_filename[len(=
ud.path)-1:] # Remove leading path<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 where =3D filename.find(&quot;#&=
quot;) # Remove trailing &#39;#rev&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filename =3D filename[:where]<br=
>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if command =3D=3D &quot;changes&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p4cmd =3D &quot;%s%s changes -m =
1 //%s&quot; % (ud.basecmd, p4opt, pathnrev)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif command =3D=3D &quot;print&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if depot_filename !=3D None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p4cmd =3D &quot;%s=
%s print -o \&quot;p4/%s\&quot; \&quot;%s\&quot;&quot; % (ud.basecmd, p4opt=
, filename, depot_filename)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise FetchError(&=
quot;No depot file name provided to p4 %s&quot; % command, ud.url)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif command =3D=3D &quot;files&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p4cmd =3D &quot;%s%s files //%s&=
quot; % (ud.basecmd, p4opt, pathnrev)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise FetchError(&quot;Invalid p=
4 command %s&quot; % command, ud.url)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not p4file:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise FetchError(&quot;Fetch: un=
able to get the P4 files from %s&quot; % depot, ud.url)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return p4cmd<br>
<br>
+=C2=A0 =C2=A0 def _p4listfiles(self, ud, d):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Return a list of the file names which are pres=
ent in the depot using the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;p4 files&#39; command, including trailing=
 &#39;#rev&#39; file revision indicator<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 p4cmd =3D self._buildp4command(ud, d, &quot;fi=
les&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.fetch2.check_network_access(d, p4cmd)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 p4fileslist =3D runfetchcmd(p4cmd, d, True)<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 p4fileslist =3D [f.rstrip() for f in p4filesli=
st.splitlines()]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not p4fileslist:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise FetchError(&quot;Unable to=
 fetch listing of p4 files from %s@%s&quot; % ud.host, ud.path)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0count =3D 0<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for file in p4file:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list =3D file.split()<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if list[2] =3D=3D &quot;delete&q=
uot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 filelist =3D []<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for filename in p4fileslist:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 item =3D filename.split(&quot; -=
 &quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lastaction =3D item[1].split()<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://logger.info" r=
el=3D"noreferrer" target=3D"_blank">logger.info</a>(&quot;File: &quot; + it=
em[0] + &quot; Last Action: &quot; + lastaction[0])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if lastaction[0] =3D=3D &quot;de=
lete&quot;:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filelist.append(item[0])<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dest =3D list[0][len(path)+1:]<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 where =3D dest.find(&quot;#&quot=
;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return filelist<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 subprocess.call(&quot;%s%s print=
 -o %s/%s %s&quot; % (p4cmd, p4opt, module, dest[:where], list[0]), shell=
=3DTrue)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 count =3D count + 1<br>
+=C2=A0 =C2=A0 def download(self, ud, d):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot; Get the list of files, fetc=
h each one &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 filelist =3D self._p4listfiles(ud, d)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not filelist:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise FetchError(&quot;No files =
found in depot %s@%s&quot; % ud.host, ud.path)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if count =3D=3D 0:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.error()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise FetchError(&quot;Fetch: No=
 files gathered from the P4 fetch&quot;, ud.url)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://logger.info" rel=3D"noreferr=
er" target=3D"_blank">logger.info</a>(&quot;Fetch &quot; + ud.url)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.utils.remove(ud.pkgdir, True)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.utils.mkdirhier(ud.pkgdir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.chdir(ud.pkgdir)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for afile in filelist:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p4fetchcmd =3D self._buildp4comm=
and(ud, d, &quot;print&quot;, afile)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.debug(1, &quot;Running %s=
&quot;, p4fetchcmd)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.fetch2.check_network_access(d=
, p4fetchcmd)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(p4fetchcmd, d)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.chdir(ud.pkgdir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;tar -czf %s p4&quot; % (ud.l=
ocalpath), d, cleanup =3D [ud.localpath])<br>
+<br>
+=C2=A0 =C2=A0 def clean(self, ud, d):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot; Cleanup p4 specific files a=
nd dirs&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.utils.remove(ud.localpath)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.utils.remove(ud.pkgdir, True)<br>
+<br>
+=C2=A0 =C2=A0 def supports_srcrev(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return True<br>
+<br>
+=C2=A0 =C2=A0 def _revision_key(self, ud, d, name):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot; Return a unique key for the=
 url &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;p4:&quot; + ud.pkgdir<br>
+<br>
+=C2=A0 =C2=A0 def _latest_revision(self, ud, d, name):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot; Return the latest upstream =
scm revision number &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 p4cmd =3D self._buildp4command(ud, d, &quot;ch=
anges&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.fetch2.check_network_access(d, p4cmd)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tip =3D runfetchcmd(p4cmd, d, True)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not tip:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise FetchError(&quot;Could not=
 determine the latest perforce changeset&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tipcset =3D tip.split(&#39; &#39;)[1]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.debug(1, &quot;p4 tip found to be chang=
eset %s&quot;, tipcset)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return tipcset<br>
+<br>
+=C2=A0 =C2=A0 def sortable_revision(self, ud, d, name):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot; Return a sortable revision =
number &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return False, self._build_revision(ud, d)<br>
+<br>
+=C2=A0 =C2=A0 def _build_revision(self, ud, d):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ud.revision<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;tar -czf %s %s&quot; % (ud.l=
ocalpath, module), d, cleanup =3D [ud.localpath])<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # cleanup<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.utils.prunedir(tmpfile)<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.8.1<br>
<br>
--<br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists=
.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</font></span></blockquote></div><br></div>

--001a1143f53ae2fea705345c9ebf--
