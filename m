Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2625.1794419232839918057
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Nov 2026 09:47:12 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@arm.com header.s=foss header.b=hLSFISIn;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 587701576
	for <bitbake-devel@lists.openembedded.org>; Wed, 11 Nov 2026 09:47:09 -0800 (PST)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 02ADC3F632
	for <bitbake-devel@lists.openembedded.org>; Wed, 11 Nov 2026 09:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794419232; bh=8tFFljhTtuE+Hz0IIFEmhQOVFCj5M6Co8nPgpSy3xVU=;
	h=From:To:Subject:Date:From;
	b=hLSFISInC3/3nvrU7cJbQFWO1bpsW6xSZj9Z9CcAqJcPhh1o9tXzDSZ1P3wXKl4jR
	 qPnRaAA37SpOkCymtXyCWgnbZQf5nsO6aeAu+7i8p3CifUTomChe1eFvPqvNqGEOBV
	 Sgb/mP8+kYCh4lAPK058zsmMtxJRdhL27L5XF/jw=
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] utils: remove exec_flat_python_func()
Date: Wed, 11 Nov 2026 17:47:08 +0000
Message-ID: <20261111174708.2800083-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-ARM-No-Footer: NoDisclaimer
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Wed, 11 Nov 2026 17:47:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20420
Content-Type: text/plain; charset="utf-8"

Nothing in bitbake has ever used this, and the last callers of this were
removed from oe-core in 2016[1].

[1] oe-core 2724511e188 ("classes/patch: move several functions to oe.pat=
ch")

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 lib/bb/utils.py | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index ec6eb2181a..1b0ff886a3 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1525,31 +1525,6 @@ def process_profilelog(fn, fn_out =3D None):
         p.print_callers()
=20
=20
-def exec_flat_python_func(func, *args, **kwargs):
-    """Execute a flat python function (defined with ``def funcname(args)=
: ...``)
-
-    Returns the return value of the function."""
-    # Prepare a small piece of python code which calls the requested fun=
ction
-    # To do this we need to prepare two things - a set of variables we c=
an use to pass
-    # the values of arguments into the calling function, and the list of=
 arguments for
-    # the function being called
-    context =3D {}
-    funcargs =3D []
-    # Handle unnamed arguments
-    aidx =3D 1
-    for arg in args:
-        argname =3D 'arg_%s' % aidx
-        context[argname] =3D arg
-        funcargs.append(argname)
-        aidx +=3D 1
-    # Handle keyword arguments
-    context.update(kwargs)
-    funcargs.extend(['%s=3D%s' % (arg, arg) for arg in kwargs.keys()])
-    code =3D 'retval =3D %s(%s)' % (func, ', '.join(funcargs))
-    comp =3D bb.utils.better_compile(code, '<string>', '<string>')
-    bb.utils.better_exec(comp, context, code, '<string>')
-    return context['retval']
-
 def edit_metadata(meta_lines, variables, varfunc, match_overrides=3DFals=
e):
     """Edit lines from a recipe or config file and modify one or more
     specified variable values set in the file using a specified callback
--=20
2.43.0

