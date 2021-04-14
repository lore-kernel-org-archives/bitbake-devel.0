Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mx.groups.io with SMTP id smtpd.web11.7174.1618365613434423269
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Apr 2021 19:00:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linux.microsoft.com header.s=default header.b=nU31DFaS;
 spf=pass (domain: linux.microsoft.com, ip: 13.77.154.182, mailfrom: pauleg@linux.microsoft.com)
Received: by linux.microsoft.com (Postfix, from userid 1054)
	id DAAD220B8003; Tue, 13 Apr 2021 19:00:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DAAD220B8003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1618365612;
	bh=WwmO9MHUO96F10o2v/aRv1eiKfaBsB5H3IzZr+aofII=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nU31DFaSJsWnXwsBlF1X1AXTIcHREj9ZO/c3vyW6dn0myZH6uTJ628O/ZJJ3xmDLw
	 DGjAE/7nUILNj2eHo/3CFKTBdvjor1DDJS1oyxXodygAv0NwEWT2JBpeamg1vyJrP+
	 zy5ZQ5+NGwN042/tHMQ2bW8DN6LUKwUwQl9YGSNE=
From: "Paul Eggleton" <paul.eggleton@linux.microsoft.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] bitbake-user-manual: add REQUIRED_VERSION and adjust PREFERRED_VERSION entry
Date: Tue, 13 Apr 2021 19:00:09 -0700
Message-Id: <c4377cdd3c36293bedaaf4fb0e0ee02c56a800a0.1618364983.git.paul.eggleton@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1618364983.git.paul.eggleton@linux.microsoft.com>
References: <cover.1618364983.git.paul.eggleton@linux.microsoft.com>

From: Paul Eggleton <paul.eggleton@microsoft.com>

Add REQUIRED_VERSION, add a reference to it in PREFERRED_VERSION and
adjust the opening statement to read slightly better.

Signed-off-by: Paul Eggleton <paul.eggleton@microsoft.com>
---
 .../bitbake-user-manual-ref-variables.rst              | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 1528b04..489fa15 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1096,8 +1096,8 @@ overview of their function and contents.
          PREFERRED_PROVIDER_aaa = "bbb"
 
    :term:`PREFERRED_VERSION`
-      If there are multiple versions of recipes available, this variable
-      determines which recipe should be given preference. You must always
+      If there are multiple versions of a recipe available, this variable
+      determines which version should be given preference. You must always
       suffix the variable with the :term:`PN` you want to
       select, and you should set :term:`PV` accordingly for
       precedence.
@@ -1117,6 +1117,10 @@ overview of their function and contents.
          end of the string. You cannot use the wildcard character in any other
          location of the string.
 
+      If a recipe with the specified version is not available, a warning
+      message will be shown. See :term:`REQUIRED_VERSION` if you want this
+      to be an error instead.
+
    :term:`PREMIRRORS`
       Specifies additional paths from which BitBake gets source code. When
       the build system searches for source code, it first tries the local
@@ -1227,6 +1231,16 @@ overview of their function and contents.
       The directory in which a local copy of a ``google-repo`` directory is
       stored when it is synced.
 
+   :term:`REQUIRED_VERSION`
+      If there are multiple versions of a recipe available, this variable
+      determines which version should be given preference. ``REQUIRED_VERSION``
+      works in exactly the same manner as :term:`PREFERRED_VERSION`, except
+      that if the specified version is not available then an error message
+      is shown and the build fails immediately.
+
+      If both ``REQUIRED_VERSION`` and ``PREFERRED_VERSION`` are set for
+      the same recipe, the ``REQUIRED_VERSION`` value applies.
+
    :term:`RPROVIDES`
       A list of package name aliases that a package also provides. These
       aliases are useful for satisfying runtime dependencies of other
-- 
1.8.3.1

