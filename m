Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA34EDF17D
	for <webhook@archiver.kernel.org>; Fri, 13 Feb 2026 16:28:34 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.75807.1771000106578717843
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 13 Feb 2026 08:28:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=SsbVYXXE;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4376acce52eso800020f8f.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 13 Feb 2026 08:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1771000104; x=1771604904; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ByRx2lcYca+RzTX3sLpemrW2h++UvIsqtlbGvy2vdqY=;
        b=SsbVYXXEjQ70xmSa+I0/6MltsMvvVvnKNK+xxS1xdiv/aUQ3l42EfkSJdNiqi7ZVoo
         Yl3CJk011+63TSrQ9z5ZwFXbivUdLMCxVMD0t9GT+w4+46amtwacIOoIxZgGbe4qrdRf
         MTEYqhF45h5EiSAH2jtWNlLFUvvDgKFqqQ6Ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771000104; x=1771604904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ByRx2lcYca+RzTX3sLpemrW2h++UvIsqtlbGvy2vdqY=;
        b=neOhte7u1Zis95L5nkaMqdxTGZYCXgqBrPB8bBswF7JK32kpRj3cu2CqXWAJddpUOh
         ydRn+GDRfBY86DX0z3VrFYE8S7qxkf+avrpIXmqy1qFihGyuDUj4BYvaRBX6tVjQkG3B
         CXOElhv5tkW5jeU6wVatsywr1rOyNDKtkdavpBtW5cprRvoTs76fbBFhfUMy+XtVXfUj
         yVsbWsng1O+gOsp5gjdYk9cN4urSpSJwCjlBAPXxq2+5+QlXz7khBviyOK1M1Fj9t1R0
         5BSLb93cXnn5eS62L6MF70Z/DYNtlShD6mpoftFQ2Hb/jd3t6/Sz5iVn+oxwuackG3+X
         GnZQ==
X-Gm-Message-State: AOJu0YyLzXph7q9qwgA0H9UUp8AmIFpWoshPLHC+63eTeM3a2CAZ+taR
	j9YKCbEmOmgAeGyPGhjs+uzQsKj0PhJ1bWS0PVoYRpVwviT8xaKeAybdQyZZxIqH+jOSp0OvLS5
	zcg6gLXY=
X-Gm-Gg: AZuq6aKvjPQ3R/rgO0NAayTdQnKX1IGX/EcShwAwxhZEq0Z/+hYXeL5hmCkh4AUvX7j
	lHVl0z4b8PWYgoEodKsgjqDrzRr/l00+VAoBukkEsXyfTVX2CVhOcY65v8Yo6/+Pmy3KKvVdhfb
	bWF32qv2bcyPI/BpvmYX40pfeHoKTfDF1vOVlg08GHfLBgWB9YCQoxoR2C3e7nBQ4QYKwjAdP0+
	oFg2c9v+3g/wGK1JrHUZ1cavlQICR+B/KIVGc+yNcPP4sVRZ8JidheHRnS82Dwjgz9FoPFU5cuj
	9uJiLpK1Y9uney0eyNR7IOLZnfTK8+QJsv2T0rJc3Kf8NjhgCmpn892SCEAwJCuO7AlcqorQSW7
	JhoW70ys8SvMAznxhdZJFd6yMy8s+292gOf1joMLt+kWK82JLDFEXxHzrC0i/o+Cj1DKz5845eM
	BHf8rP0f5LFYb6cn/IuYGn3EIVBDzKdttNZ0SWB2YjikGEhAjX7uOYM9Izu42pMQ==
X-Received: by 2002:a05:6000:2408:b0:435:9612:2d24 with SMTP id ffacd0b85a97d-43797920afdmr5272170f8f.53.1771000103903;
        Fri, 13 Feb 2026 08:28:23 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e20e:afdc:37ec:38d1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6c1b4sm6046701f8f.14.2026.02.13.08.28.22
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 08:28:23 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] fetch: Drop osc (OpenSUSE Build Service) fetcher
Date: Fri, 13 Feb 2026 16:28:21 +0000
Message-ID: <20260213162822.1758624-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 13 Feb 2026 16:28:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19029

The OpenSUSE Build Service fetcher was for a specialist niche usecase which never
went into production use as far as I know. At this point it makes sense to remove
it as it is unused and bitrotted.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../bitbake-user-manual-fetching.rst          |   3 -
 .../bitbake-user-manual-ref-variables.rst     |   3 -
 lib/bb/fetch2/__init__.py                     |   2 -
 lib/bb/fetch2/osc.py                          | 165 ------------------
 4 files changed, 173 deletions(-)
 delete mode 100644 lib/bb/fetch2/osc.py

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index efc0f8456ee..27e276885a6 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -87,7 +87,6 @@ Here are some examples that show commonly used mirror definitions::
       cvs://.*/.\*  http://somemirror.org/sources/ \
       git://.*/.\*  http://somemirror.org/sources/ \
       hg://.*/.\*   http://somemirror.org/sources/ \
-      osc://.*/.\*  http://somemirror.org/sources/ \
       p4://.*/.\*   http://somemirror.org/sources/ \
      svn://.*/.\*   http://somemirror.org/sources/"
 
@@ -828,8 +827,6 @@ Fetch submodules also exist for the following:
 
 -  Mercurial (``hg://``)
 
--  OSC (``osc://``)
-
 -  S3 (``s3://``)
 
 -  Secure FTP (``sftp://``)
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index c75f2c27b32..f8f824f9f5a 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1672,9 +1672,6 @@ overview of their function and contents.
 
       -  ``npm://``: Fetches JavaScript modules from a registry.
 
-      -  ``osc://``: Fetches files from an OSC (OpenSUSE Build service)
-         revision control repository.
-
       -  ``p4://``: Fetches files from a Perforce (``p4``) revision
          control repository.
 
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index d21e9c18fa0..7e0ef05246f 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -2112,7 +2112,6 @@ from . import sftp
 from . import s3
 from . import perforce
 from . import hg
-from . import osc
 from . import repo
 from . import clearcase
 from . import npm
@@ -2134,7 +2133,6 @@ methods.append(sftp.SFTP())
 methods.append(s3.S3())
 methods.append(perforce.Perforce())
 methods.append(hg.Hg())
-methods.append(osc.Osc())
 methods.append(repo.Repo())
 methods.append(clearcase.ClearCase())
 methods.append(npm.Npm())
diff --git a/lib/bb/fetch2/osc.py b/lib/bb/fetch2/osc.py
deleted file mode 100644
index 495ac8a30aa..00000000000
--- a/lib/bb/fetch2/osc.py
+++ /dev/null
@@ -1,165 +0,0 @@
-#
-# Copyright BitBake Contributors
-#
-# SPDX-License-Identifier: GPL-2.0-only
-#
-"""
-Bitbake "Fetch" implementation for osc (Opensuse build service client).
-Based on the svn "Fetch" implementation.
-
-"""
-
-import logging
-import os
-import re
-import  bb
-from    bb.fetch2 import FetchMethod
-from    bb.fetch2 import FetchError
-from    bb.fetch2 import MissingParameterError
-from    bb.fetch2 import runfetchcmd
-
-logger = logging.getLogger(__name__)
-
-class Osc(FetchMethod):
-    """Class to fetch a module or modules from Opensuse build server
-       repositories."""
-
-    def supports(self, ud, d):
-        """
-        Check to see if a given url can be fetched with osc.
-        """
-        return ud.type in ['osc']
-
-    def urldata_init(self, ud, d):
-        if not "module" in ud.parm:
-            raise MissingParameterError('module', ud.url)
-
-        ud.module = ud.parm["module"]
-
-        # Create paths to osc checkouts
-        oscdir = d.getVar("OSCDIR") or (d.getVar("DL_DIR") + "/osc")
-        relpath = self._strip_leading_slashes(ud.path)
-        ud.oscdir = oscdir
-        ud.pkgdir = os.path.join(oscdir, ud.host)
-        ud.moddir = os.path.join(ud.pkgdir, relpath, ud.module)
-
-        if 'rev' in ud.parm:
-            ud.revision = ud.parm['rev']
-        else:
-            pv = d.getVar("PV", False)
-            rev = bb.fetch2.srcrev_internal_helper(ud, d, '')
-            if rev:
-                ud.revision = rev
-            else:
-                ud.revision = ""
-
-        ud.localfile = d.expand('%s_%s_%s.tar.gz' % (ud.module.replace('/', '.'), relpath.replace('/', '.'), ud.revision))
-
-    def _buildosccommand(self, ud, d, command):
-        """
-        Build up an ocs commandline based on ud
-        command is "fetch", "update", "info"
-        """
-
-        basecmd = d.getVar("FETCHCMD_osc") or "/usr/bin/env osc"
-
-        proto = ud.parm.get('protocol', 'https')
-
-        options = []
-
-        config = "-c %s" % self.generate_config(ud, d)
-
-        if getattr(ud, 'revision', ''):
-            options.append("-r %s" % ud.revision)
-
-        coroot = self._strip_leading_slashes(ud.path)
-
-        if command == "fetch":
-            osccmd = "%s %s -A %s://%s co %s/%s %s" % (basecmd, config, proto, ud.host, coroot, ud.module, " ".join(options))
-        elif command == "update":
-            osccmd = "%s %s -A %s://%s up %s" % (basecmd, config, proto, ud.host, " ".join(options))
-        elif command == "api_source":
-            osccmd = "%s %s -A %s://%s api source/%s/%s" % (basecmd, config, proto, ud.host, coroot, ud.module)
-        else:
-            raise FetchError("Invalid osc command %s" % command, ud.url)
-
-        return osccmd
-
-    def _latest_revision(self, ud, d, name):
-        """
-        Fetch latest revision for the given package
-        """
-        api_source_cmd = self._buildosccommand(ud, d, "api_source")
-
-        output = runfetchcmd(api_source_cmd, d)
-        match = re.match(r'<directory ?.* rev="(\d+)".*>', output)
-        if match is None:
-            raise FetchError("Unable to parse osc response", ud.url)
-        return match.groups()[0]
-
-    def _revision_key(self, ud, d, name):
-        """
-        Return a unique key for the url
-        """
-        # Collapse adjacent slashes
-        slash_re = re.compile(r"/+")
-        rev = getattr(ud, 'revision', "latest")
-        return "osc:%s%s.%s.%s" % (ud.host, slash_re.sub(".", ud.path), name, rev)
-
-    def download(self, ud, d):
-        """
-        Fetch url
-        """
-
-        logger.debug2("Fetch: checking for module directory '" + ud.moddir + "'")
-
-        if os.access(ud.moddir, os.R_OK):
-            oscupdatecmd = self._buildosccommand(ud, d, "update")
-            logger.info("Update "+ ud.url)
-            # update sources there
-            logger.debug("Running %s", oscupdatecmd)
-            bb.fetch2.check_network_access(d, oscupdatecmd, ud.url)
-            runfetchcmd(oscupdatecmd, d, workdir=ud.moddir)
-        else:
-            oscfetchcmd = self._buildosccommand(ud, d, "fetch")
-            logger.info("Fetch " + ud.url)
-            # check out sources there
-            bb.utils.mkdirhier(ud.pkgdir)
-            logger.debug("Running %s", oscfetchcmd)
-            bb.fetch2.check_network_access(d, oscfetchcmd, ud.url)
-            runfetchcmd(oscfetchcmd, d, workdir=ud.pkgdir)
-
-        # tar them up to a defined filename
-        runfetchcmd("tar -czf %s %s" % (ud.localpath, ud.module), d,
-                    cleanup=[ud.localpath], workdir=os.path.join(ud.pkgdir + ud.path))
-
-    def supports_srcrev(self):
-        return False
-
-    def generate_config(self, ud, d):
-        """
-        Generate a .oscrc to be used for this run.
-        """
-
-        config_path = os.path.join(ud.oscdir, "oscrc")
-        if not os.path.exists(ud.oscdir):
-            bb.utils.mkdirhier(ud.oscdir)
-
-        if (os.path.exists(config_path)):
-            os.remove(config_path)
-
-        f = open(config_path, 'w')
-        proto = ud.parm.get('protocol', 'https')
-        f.write("[general]\n")
-        f.write("apiurl = %s://%s\n" % (proto, ud.host))
-        f.write("su-wrapper = su -c\n")
-        f.write("build-root = %s\n" % d.getVar('WORKDIR'))
-        f.write("urllist = %s\n" % d.getVar("OSCURLLIST"))
-        f.write("extra-pkgs = gzip\n")
-        f.write("\n")
-        f.write("[%s://%s]\n" % (proto, ud.host))
-        f.write("user = %s\n" % ud.parm["user"])
-        f.write("pass = %s\n" % ud.parm["pswd"])
-        f.close()
-
-        return config_path

