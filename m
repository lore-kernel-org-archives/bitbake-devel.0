Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
 by mx.groups.io with SMTP id smtpd.web12.2616.1622575369432752287
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Jun 2021 12:22:49 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: 0leil.net, ip: 217.70.178.230, mailfrom: foss@0leil.net)
Received: (Authenticated sender: foss@0leil.net)
	by relay10.mail.gandi.net (Postfix) with ESMTPSA id 6ACE1240009;
	Tue,  1 Jun 2021 19:22:45 +0000 (UTC)
From: "Quentin Schulz" <foss@0leil.net>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Quentin Schulz <foss@0leil.net>
Subject: [PATCH] doc: user-manual: ref-manual: remove mentions to BB_SETSCENE_VERIFY_FUNCTION2
Date: Tue,  1 Jun 2021 21:22:35 +0200
Message-Id: <20210601192235.9371-1-foss@0leil.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This variable was removed in July 2019 with commit
5deaa5df730a "runqueue: Drop unused BB_SETSCENE_VERIFY_FUNCTION2".

There's no replacement, so let's update the documentation to not mention
this variable anymore.

This was found by running:
git grep -hoP '^   :term:`\K\w+(?=`)' doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | \
  xargs -I{} sh -c \
    "grep -Rq --include='*.py' --include='*.conf' --include='*.bbclass' --include='*.bb' --include='*.bbappend' --include='*.inc' \
      -w -E {}'_*(_[a-z]+[0-9a-z]*[a-z]+)*' || \
    echo {}"

Signed-off-by: Quentin Schulz <foss@0leil.net>
---
 .../bitbake-user-manual-execution.rst                 |  7 -------
 .../bitbake-user-manual-metadata.rst                  |  4 ----
 .../bitbake-user-manual-ref-variables.rst             | 11 -----------
 3 files changed, 22 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
index 14c342a6..84d65fa9 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
@@ -648,13 +648,6 @@ compiled binary. To handle this, BitBake calls the
 each successful setscene task to know whether or not it needs to obtain
 the dependencies of that task.
 
-Finally, after all the setscene tasks have executed, BitBake calls the
-function listed in
-:term:`BB_SETSCENE_VERIFY_FUNCTION2`
-with the list of tasks BitBake thinks has been "covered". The metadata
-can then ensure that this list is correct and can inform BitBake that it
-wants specific tasks to be run regardless of the setscene result.
-
 You can find more information on setscene metadata in the
 :ref:`bitbake-user-manual/bitbake-user-manual-metadata:task checksums and setscene`
 section.
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 77c107af..20c330e6 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -1920,10 +1920,6 @@ The following list describes related variables:
    Specifies a function BitBake calls that determines whether BitBake
    requires a setscene dependency to be met.
 
--  :term:`BB_SETSCENE_VERIFY_FUNCTION2`:
-   Specifies a function to call that verifies the list of planned task
-   execution before the main task execution happens.
-
 -  :term:`BB_STAMP_POLICY`: Defines the mode
    for comparing timestamps of stamp files.
 
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index adb311ab..a1e2440b 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -426,17 +426,6 @@ overview of their function and contents.
       The function specified by this variable returns a "True" or "False"
       depending on whether the dependency needs to be met.
 
-   :term:`BB_SETSCENE_VERIFY_FUNCTION2`
-      Specifies a function to call that verifies the list of planned task
-      execution before the main task execution happens. The function is
-      called once BitBake has a list of setscene tasks that have run and
-      either succeeded or failed.
-
-      The function allows for a task list check to see if they make sense.
-      Even if BitBake was planning to skip a task, the returned value of
-      the function can force BitBake to run the task, which is necessary
-      under certain metadata defined circumstances.
-
    :term:`BB_SIGNATURE_EXCLUDE_FLAGS`
       Lists variable flags (varflags) that can be safely excluded from
       checksum and dependency data for keys in the datastore. When
-- 
2.20.1

