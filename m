Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web09.2641.1622575341191913398
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Jun 2021 12:22:21 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: 0leil.net, ip: 217.70.183.201, mailfrom: foss@0leil.net)
Received: (Authenticated sender: foss@0leil.net)
	by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 2F0091BF206;
	Tue,  1 Jun 2021 19:22:18 +0000 (UTC)
From: "Quentin Schulz" <foss@0leil.net>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Quentin Schulz <foss@0leil.net>
Subject: [PATCH] doc: user-manual: remove mentions to BBVERSIONS
Date: Tue,  1 Jun 2021 21:22:06 +0200
Message-Id: <20210601192206.9251-1-foss@0leil.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BBVERSIONS support was dropped in November 2016 in commit
0bb188f01e39 "ast: remove BBVERSIONS support".

Let's update the documentation to reflect this.

This was found by running:

git grep -hoP '^   :term:`\K\w+(?=`)' doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | \
  xargs -I{} sh -c \
    "grep -Rq --include='*.py' --include='*.conf' --include='*.bbclass' --include='*.bb' --include='*.bbappend' --include='*.inc' \
      -w -E {}'_*(_[a-z]+[0-9a-z]*[a-z]+)*' || \
     echo {}"

Signed-off-by: Quentin Schulz <foss@0leil.net>
---
 .../bitbake-user-manual-metadata.rst          | 41 ++++---------------
 .../bitbake-user-manual-ref-variables.rst     | 10 -----
 2 files changed, 9 insertions(+), 42 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 615c9f9c..77c107af 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -1650,10 +1650,15 @@ user interfaces:
 Variants - Class Extension Mechanism
 ====================================
 
-BitBake supports two features that facilitate creating from a single
-recipe file multiple incarnations of that recipe file where all
-incarnations are buildable. These features are enabled through the
-:term:`BBCLASSEXTEND` and :term:`BBVERSIONS` variables.
+BitBake supports multiple incarnations of a recipe file via the
+:term:`BBCLASSEXTEND` variable.
+
+The :term:`BBCLASSEXTEND` variable is a space separated list of classes used
+to "extend" the recipe for each variant. Here is an example that results in a
+second incarnation of the current recipe being available. This second
+incarnation will have the "native" class inherited. ::
+
+      BBCLASSEXTEND = "native"
 
 .. note::
 
@@ -1663,34 +1668,6 @@ incarnations are buildable. These features are enabled through the
    class. For specific examples, see the OE-Core native , nativesdk , and
    multilib classes.
 
--  ``BBCLASSEXTEND``: This variable is a space separated list of
-   classes used to "extend" the recipe for each variant. Here is an
-   example that results in a second incarnation of the current recipe
-   being available. This second incarnation will have the "native" class
-   inherited. ::
-
-      BBCLASSEXTEND = "native"
-
--  ``BBVERSIONS``: This variable allows a single recipe to build
-   multiple versions of a project from a single recipe file. You can
-   also specify conditional metadata (using the
-   :term:`OVERRIDES` mechanism) for a single
-   version, or an optionally named range of versions. Here is an
-   example::
-
-      BBVERSIONS = "1.0 2.0 git"
-      SRC_URI_git = "git://someurl/somepath.git"
-
-      BBVERSIONS = "1.0.[0-6]:1.0.0+ 1.0.[7-9]:1.0.7+"
-      SRC_URI_append_1.0.7+ = "file://some_patch_which_the_new_versions_need.patch;patch=1"
-
-   The name of the range defaults to the original version of the recipe. For
-   example, in OpenEmbedded, the recipe file ``foo_1.0.0+.bb`` creates a default
-   name range of ``1.0.0+``. This is useful because the range name is not only
-   placed into overrides, but it is also made available for the metadata to use
-   in the variable that defines the base recipe versions for use in ``file://``
-   search paths (:term:`FILESPATH`).
-
 Dependencies
 ============
 
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index e1b640e2..adb311ab 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -797,16 +797,6 @@ overview of their function and contents.
       Allows you to use a configuration file to add to the list of
       command-line target recipes you want to build.
 
-   :term:`BBVERSIONS`
-      Allows a single recipe to build multiple versions of a project from a
-      single recipe file. You also able to specify conditional metadata
-      using the :term:`OVERRIDES` mechanism for a
-      single version or for an optionally named range of versions.
-
-      For more information on ``BBVERSIONS``, see the
-      ":ref:`bitbake-user-manual/bitbake-user-manual-metadata:variants - class extension mechanism`"
-      section.
-
    :term:`BITBAKE_UI`
       Used to specify the UI module to use when running BitBake. Using this
       variable is equivalent to using the ``-u`` command-line option.
-- 
2.20.1

