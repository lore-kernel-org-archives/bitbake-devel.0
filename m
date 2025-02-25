Return-Path: <michaelestner@web.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC1FC021B2
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 18:34:39 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by mx.groups.io with SMTP id smtpd.web11.16571.1740508474825699958
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Feb 2025 10:34:35 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=michaelestner@web.de header.s=s29768273 header.b=OY+Dx8ys;
 spf=pass (domain: web.de, ip: 212.227.15.4, mailfrom: michaelestner@web.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740508473; x=1741113273; i=michaelestner@web.de;
	bh=EkpBHzRWRqNpckp3rQlPOf4vdyX3bgk3rxO1gnkGAfo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OY+Dx8ystpCZDLzp/n+ivbHn7vvThtsdXeugX5GY+bvALFT6OVI07/v4mCmgbiTr
	 wFm6jGqmQ/xa73WpvhBeh+jebdFRrVGv9Baigc8seaYlBXMvUi+cKcCY8dq0z1bBO
	 O7woZ9WUKzHmu0mrXKWyrfyTBYtwvjiSqxjhSxa/IvHZf9AUHHSaqm9OkscwxTmhE
	 Bs3P3LbjsVgD1sxd9+S7YCIbBYW3y47jsnumh2tTMEoZ/zS8kIRUmibWEcr5SzBJE
	 W5c0ZODtwdq3glcD+5T6uKT4HnUMxRIAo/2RVAkvUxtp1HmOGRBPGGyw9tNQsb3+K
	 8vyLSgAVToFKDYfd4A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from del01453.ebgroup.elektrobit.com ([87.150.19.135]) by
 smtp.web.de (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MbTLB-1tC07F3r3J-00gYFZ; Tue, 25 Feb 2025 19:34:32 +0100
From: Michael Estner <michaelestner@web.de>
To: bitbake-devel@lists.openembedded.org
Cc: Michael Estner <michaelestner@web.de>
Subject: [bitbake-devel][PATCH 1/1] lib: Remove double imports
Date: Tue, 25 Feb 2025 19:34:25 +0100
Message-Id: <20250225183425.232815-1-michaelestner@web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fmQEBklgMGwQ5SLOS2SD0ujU2+HU2n50QU7WFbTHRGOBxBog30/
 9+DSJq87CKBKzRCfM0cVjZESBpFv0y60KFoDa46sQC+panjwzdlp2a5ABLFbYGHdP/AE/Rb
 FxbYIBEct0zW1oj9cUkJgKUMDHl678dltxhIOPSoDYNt+RUIDhVUGwQInbUOfnB78auIwcU
 9cEQIzMy9y0DZ0DHQ+7Ww==
UI-OutboundReport: notjunk:1;M01:P0:XVRTT6MGADU=;wdLrUjTWN3Tza7jcTfWT/d9vZPl
 kSWy5GIt0BHLeznc1J9uMy20M0WMce6ruUGKUlbu69+Um4HylpM8ANaVq7yI6jm6TVoUb7hVJ
 39tv2oxAz1wGctlY2+xaLwNjbObXhscHGwZgi9SCA1zqouMMzp/9tFb1DOFCIF0hSbZ0HuRNj
 xmjl47cfEIOjNPMHpOjUbISnHPEmTmYnmRUA6w7Zlh6cgyhvFtKEyEdvLdFJNco1YXXC2/C1n
 seMuPbIK380EJe+0sUL8POYwV6nqKXmEV6ktfzP+ubo9bT2gdR/GUUE+E30mRIRSSZBC8M7Ue
 eB8tgdtTWbhRJKt7O3JDFzt/XIvBput0J7fs4WpgxOugpqfuhA90BLrcGx4ONBG0KdV1YWGvn
 /5F3Y2XwhsGldvx9DrH/N8wcDPu0iVBAGgZHGSJRibRDKTKKWPcUxVUOZBUtNrxd2zmkKtrUa
 q++8Wubk2J97k0NIkfYervcqdd+VmIiZ8cLxVG6WtFHKeDtMF1ysaq63aCPQBN8obJnITdRgr
 aYcdNl5x8fJsUBMt4pu4EHOkA/A0nmAMlsrN35g+a03AeJp+gBAOIk/BEC+ugX/BpHJ7dXtoB
 ZMk+yuLDg0g5I4RDE83XbPHCUKDfg79+7ieHAvcEGvTQESz6AL2isTJuvpZStuOOsydM4V9u4
 H7k2L1EgCeLVwjBs+GKJJ098NY/+7u1HBRRhbnaqxwsLmLhWxYBEg8U1LvaotqbDMVGBJngOe
 8vRjvAxJk5WpZ79SXbQR0SntxuNOAmllT4y1/VDBBmFp8mBN65vnO+iS2WjKijuR2fkkJyX6M
 F9TF9c3pbnFQZLlhCQCMAJM0ttHyMxTz3RLgXzbSRC4CyAYlStNaxuLOzoA6cgiSgwwSeeNt2
 K5kxX3m7nWYldwEjBXqr/0WCu+EsrIEuObApZ17R/3o95vTaTDHIhWG+Yv6zEm0IXG4gInojm
 +Ue+VCKdWL4ZXFYg4ezjmZTZpjluEM/kpfDsxHYEfMlOTmvZUIuHaqsDHysRDe1aYdCkWqtni
 ro6V1MrJQ9N7ZpKTc0aovgbG67HGpSQ08cq/hR6M6wCuMasxUGDP6ykYeMzyTHL+CoeryN0W+
 41xzF+xgxaP+G2bpATHq/c7p650/J2uIP2xIBQ+CCe9p8YCbxx+gr+vLnISlpXxGlZrlV/RhN
 h9ZcT1F5yj4K+qQXySe0Chj9ehE5IitcVmME2CF1OwvyQ5Wqw7JJrmBHytmwDbQEYMx5g59KD
 zee3UbIx4cB1f0tzGAVwno4P38+vMRpeDkQgNjGaDkPqfwBKojhOkgE/h0YddXXzy79heheBW
 k3yu4/BNS3Ghq7iOSmd9rLPT+cKWSuknvNF5kny/daeRlW41ryoX3AGsY7JWqFlqRJmqH0HQh
 qx5G/xgGBxS6ukpH7xG0HcOm7bpVhNAlUaG+LPSX7vkJcJOJGYH8WqcNaf
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 18:34:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17320

* Remove double imports mentioned by pylint

Signed-off-by: Michael Estner <michaelestner@web.de>
=2D--
 lib/bb/__init__.py                                 | 1 -
 lib/bb/acl.py                                      | 2 --
 lib/bb/fetch2/git.py                               | 1 -
 lib/bb/fetch2/gitsm.py                             | 2 +-
 lib/bb/runqueue.py                                 | 1 -
 lib/bs4/__init__.py                                | 1 -
 lib/bs4/diagnose.py                                | 1 -
 lib/ply/yacc.py                                    | 1 -
 lib/toaster/orm/models.py                          | 3 +--
 lib/toaster/toastergui/templatetags/projecttags.py | 1 -
 lib/toaster/toastergui/views.py                    | 2 --
 lib/toaster/toastermain/settings.py                | 1 -
 12 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index 574e0de5b..876f7e397 100644
=2D-- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -194,7 +194,6 @@ def deprecated(func, name=3DNone, advice=3D""):
 # For compatibility
 def deprecate_import(current, modulename, fromlist, renames =3D None):
     """Import objects from one module into another, wrapping them with a =
DeprecationWarning"""
-    import sys

     module =3D __import__(modulename, fromlist =3D fromlist)
     for position, objname in enumerate(fromlist):
diff --git a/lib/bb/acl.py b/lib/bb/acl.py
index 0f41b275c..e9dbdb617 100755
=2D-- a/lib/bb/acl.py
+++ b/lib/bb/acl.py
@@ -195,8 +195,6 @@ class ACL(object):

 def main():
     import argparse
-    import pwd
-    import grp
     from pathlib import Path

     parser =3D argparse.ArgumentParser()
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 6badda597..168f14d0c 100644
=2D-- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -817,7 +817,6 @@ class Git(FetchMethod):
         """
         Return True if git-lfs can be found, False otherwise.
         """
-        import shutil
         return shutil.which("git-lfs", path=3Dd.getVar('PATH')) is not No=
ne

     def _get_repo_url(self, ud):
diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index ba62517f0..bab1bf258 100644
=2D-- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -264,7 +264,7 @@ class GitSM(Git):
         Git.clean(self, ud, d)

     def implicit_urldata(self, ud, d):
-        import shutil, subprocess, tempfile
+        import subprocess

         urldata =3D []
         def add_submodule(ud, url, module, modpath, workdir, d):
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index ffb2d2849..ad4ce0b0e 100644
=2D-- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -477,7 +477,6 @@ class RunQueueData:
         self.runtaskentries =3D {}

     def runq_depends_names(self, ids):
-        import re
         ret =3D []
         for id in ids:
             nam =3D os.path.basename(id)
diff --git a/lib/bs4/__init__.py b/lib/bs4/__init__.py
index d8ad5e1dc..725203d94 100644
=2D-- a/lib/bs4/__init__.py
+++ b/lib/bs4/__init__.py
@@ -835,6 +835,5 @@ class FeatureNotFound(ValueError):

 #If this file is run as a script, act as an HTML pretty-printer.
 if __name__ =3D=3D '__main__':
-    import sys
     soup =3D BeautifulSoup(sys.stdin)
     print((soup.prettify()))
diff --git a/lib/bs4/diagnose.py b/lib/bs4/diagnose.py
index e079772e6..469279534 100644
=2D-- a/lib/bs4/diagnose.py
+++ b/lib/bs4/diagnose.py
@@ -17,7 +17,6 @@ import tempfile
 import time
 import traceback
 import sys
-import cProfile

 def diagnose(data):
     """Diagnostic suite for isolating common problems.
diff --git a/lib/ply/yacc.py b/lib/ply/yacc.py
index 381b50cf0..529f85b08 100644
=2D-- a/lib/ply/yacc.py
+++ b/lib/ply/yacc.py
@@ -1122,7 +1122,6 @@ class LRParser:
 # manipulate the rules that make up a grammar.
 # -----------------------------------------------------------------------=
------

-import re

 # regex matching identifiers
 _is_identifier =3D re.compile(r'^[a-zA-Z0-9_-]+$')
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 19c968620..e2f488ed8 100644
=2D-- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -79,7 +79,6 @@ if 'sqlite' in settings.DATABASES['default']['ENGINE']:
     # end of HACK

 class GitURLValidator(validators.URLValidator):
-    import re
     regex =3D re.compile(
         r'^(?:ssh|git|http|ftp)s?://'  # http:// or https://
         r'(?:(?:[A-Z0-9](?:[A-Z0-9-]{0,61}[A-Z0-9])?\.)+(?:[A-Z]{2,6}\.?|=
[A-Z0-9-]{2,}\.?)|'  # domain...
@@ -1500,7 +1499,7 @@ class Layer_Version(models.Model):
     # code lifted, with adaptations, from the layerindex-web application
     # https://git.yoctoproject.org/cgit/cgit.cgi/layerindex-web/
     def _handle_url_path(self, base_url, path):
-        import re, posixpath
+        import posixpath
         if base_url:
             if self.dirpath:
                 if path:
diff --git a/lib/toaster/toastergui/templatetags/projecttags.py b/lib/toas=
ter/toastergui/templatetags/projecttags.py
index bd398f001..aee9bbcd1 100644
=2D-- a/lib/toaster/toastergui/templatetags/projecttags.py
+++ b/lib/toaster/toastergui/templatetags/projecttags.py
@@ -233,7 +233,6 @@ def filter_sizeovertotal(package_object, total_size):

     return '{:.1%}'.format(float(size)/float(total_size))

-from django.utils.safestring import mark_safe
 @register.filter
 def format_vpackage_rowclass(size):
     if size =3D=3D -1:
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/view=
s.py
index 40aed265d..061e6436c 100644
=2D-- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -372,7 +372,6 @@ def _get_parameters_values(request, default_count, def=
ault_order):
 # set cookies for parameters. this is usefull in case parameters are set
 # manually from the GET values of the link
 def _set_parameters_values(pagesize, orderby, request):
-    from django.urls import resolve
     current_url =3D resolve(request.path_info).url_name
     request.session['%s_count' % current_url] =3D pagesize
     request.session['%s_orderby' % current_url] =3Dorderby
@@ -699,7 +698,6 @@ class LazyEncoder(json.JSONEncoder):
         return super(LazyEncoder, self).default(obj)

 from toastergui.templatetags.projecttags import filtered_filesizeformat
-import os
 def _get_dir_entries(build_id, target_id, start):
     node_str =3D {
         Target_File.ITYPE_REGULAR   : '-',
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain=
/settings.py
index e06adc5a9..d2a449627 100644
=2D-- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -298,7 +298,6 @@ SOUTH_TESTS_MIGRATE =3D False

 # We automatically detect and install applications here if
 # they have a 'models.py' or 'views.py' file
-import os
 currentdir =3D os.path.dirname(__file__)
 for t in os.walk(os.path.dirname(currentdir)):
     modulename =3D os.path.basename(t[0])
=2D-
2.25.1


