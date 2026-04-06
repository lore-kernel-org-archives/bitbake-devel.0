Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE330FB516A
	for <webhook@archiver.kernel.org>; Mon,  6 Apr 2026 20:24:58 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.64393.1775507090702900807
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Apr 2026 13:24:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm2 header.b=NZ9Gv4fQ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1329275-202604062024485dbdc6ef3200020716-n6pqsj@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202604062024485dbdc6ef3200020716
        for <bitbake-devel@lists.openembedded.org>;
        Mon, 06 Apr 2026 22:24:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=rl8rcG6D68q5Fi35Q1eJX8FzZ9P+QwLQCGzlYrWUx54=;
 b=NZ9Gv4fQPzLnNR63IM/YY4vkmEzgsVu1zGDqZ/fzY6LpxLZVse5MZFVxyUDbbelGWdzMzK
 lVRJ0P43F7Gz3fNCfLnNpvJskEjD/d7+jGvjk8RgY+ty1EcCRpQq8zbg4fG5RSQ6GGzQh0Hw
 Ymmhh0LAd6fppir+PRlKRzwVhjTYeOtjl6gvBI31DF9uBq9ijBHIy+oHK71l0yQLRkWur2SU
 zuxxgdkXfcKjm1bVDtpRfuIt+4s4KXDbHtdsk14oVKxb59YNVUAH7DjEedhT8PLncYPYKtGy
 Z6X4m/Ur4Lnmi4qakD9njH1AutksQJnxjyqReOC45bNkCFn/G8MsIF3A==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 3/4] bitbake-setup: add contrib extra-remotes to default-registry configs
Date: Mon,  6 Apr 2026 22:24:04 +0200
Message-ID: <20260406202430.1856836-4-adrian.freihofer@siemens.com>
In-Reply-To: <20260406202430.1856836-1-adrian.freihofer@siemens.com>
References: <20260406202430.1856836-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 06 Apr 2026 20:24:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19333

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Extend the default-registry configurations with 'contrib' extra-remotes
for the bitbake, openembedded-core, and meta-yocto layer sources.

The contrib remotes point to the SSH push mirrors on push.openembedded.org
and are marked optional=true, meaning they are excluded by the default
'non-optional' filter and must be explicitly requested via:

    bitbake-setup init --extra-remotes-filter all ...
    bitbake-setup init --extra-remotes-filter contrib ...

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 .../oe-nodistro-master.conf.json              | 16 +++++++++++--
 .../oe-nodistro-whinlatter.conf.json          | 16 +++++++++++--
 .../configurations/poky-master.conf.json      | 24 ++++++++++++++++---
 .../configurations/poky-whinlatter.conf.json  | 24 ++++++++++++++++---
 4 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/default-registry/configurations/oe-nodistro-master.conf.json b/default-registry/configurations/oe-nodistro-master.conf.json
index 5aa148d42..c06f5602a 100644
--- a/default-registry/configurations/oe-nodistro-master.conf.json
+++ b/default-registry/configurations/oe-nodistro-master.conf.json
@@ -5,14 +5,26 @@
             "git-remote": {
                 "uri": "https://git.openembedded.org/bitbake",
                 "branch": "master",
-                "rev": "master"
+                "rev": "master",
+                "extra-remotes": {
+                    "contrib": {
+                        "uri": "ssh://git@push.openembedded.org/bitbake-contrib",
+                        "optional": true
+                    }
+                }
             }
         },
         "openembedded-core": {
             "git-remote": {
                 "uri": "https://git.openembedded.org/openembedded-core",
                 "branch": "master",
-                "rev": "master"
+                "rev": "master",
+                "extra-remotes": {
+                    "contrib": {
+                        "uri": "ssh://git@push.openembedded.org/openembedded-core-contrib",
+                        "optional": true
+                    }
+                }
             }
         },
         "yocto-docs": {
diff --git a/default-registry/configurations/oe-nodistro-whinlatter.conf.json b/default-registry/configurations/oe-nodistro-whinlatter.conf.json
index 7b183ae1c..b8d5b1eca 100644
--- a/default-registry/configurations/oe-nodistro-whinlatter.conf.json
+++ b/default-registry/configurations/oe-nodistro-whinlatter.conf.json
@@ -10,7 +10,13 @@
                     }
                 },
                 "branch": "2.16",
-                "rev": "2.16"
+                "rev": "2.16",
+                "extra-remotes": {
+                    "contrib": {
+                        "uri": "ssh://git@push.openembedded.org/bitbake-contrib",
+                        "optional": true
+                    }
+                }
             }
         },
         "openembedded-core": {
@@ -21,7 +27,13 @@
                     }
                 },
                 "branch": "whinlatter",
-                "rev": "whinlatter"
+                "rev": "whinlatter",
+                "extra-remotes": {
+                    "contrib": {
+                        "uri": "ssh://git@push.openembedded.org/openembedded-core-contrib",
+                        "optional": true
+                    }
+                }
             }
         },
         "yocto-docs": {
diff --git a/default-registry/configurations/poky-master.conf.json b/default-registry/configurations/poky-master.conf.json
index 58d379648..bb7c53e10 100644
--- a/default-registry/configurations/poky-master.conf.json
+++ b/default-registry/configurations/poky-master.conf.json
@@ -5,21 +5,39 @@
             "git-remote": {
                 "uri": "https://git.openembedded.org/bitbake",
                 "branch": "master",
-                "rev": "master"
+                "rev": "master",
+                "extra-remotes": {
+                    "contrib": {
+                        "uri": "ssh://git@push.openembedded.org/bitbake-contrib",
+                        "optional": true
+                    }
+                }
             }
         },
         "openembedded-core": {
             "git-remote": {
                 "uri": "https://git.openembedded.org/openembedded-core",
                 "branch": "master",
-                "rev": "master"
+                "rev": "master",
+                "extra-remotes": {
+                    "contrib": {
+                        "uri": "ssh://git@push.openembedded.org/openembedded-core-contrib",
+                        "optional": true
+                    }
+                }
             }
         },
         "meta-yocto": {
             "git-remote": {
                 "uri": "https://git.yoctoproject.org/meta-yocto",
                 "branch": "master",
-                "rev": "master"
+                "rev": "master",
+                "extra-remotes": {
+                    "contrib": {
+                        "uri": "ssh://git@push.openembedded.org/meta-yocto-contrib",
+                        "optional": true
+                    }
+                }
             }
         },
         "yocto-docs": {
diff --git a/default-registry/configurations/poky-whinlatter.conf.json b/default-registry/configurations/poky-whinlatter.conf.json
index 4827ebe11..ba82c5ed6 100644
--- a/default-registry/configurations/poky-whinlatter.conf.json
+++ b/default-registry/configurations/poky-whinlatter.conf.json
@@ -10,7 +10,13 @@
                     }
                 },
                 "branch": "2.16",
-                "rev": "2.16"
+                "rev": "2.16",
+                "extra-remotes": {
+                    "contrib": {
+                        "uri": "ssh://git@push.openembedded.org/bitbake-contrib",
+                        "optional": true
+                    }
+                }
             }
         },
         "openembedded-core": {
@@ -21,7 +27,13 @@
                     }
                 },
                 "branch": "whinlatter",
-                "rev": "whinlatter"
+                "rev": "whinlatter",
+                "extra-remotes": {
+                    "contrib": {
+                        "uri": "ssh://git@push.openembedded.org/openembedded-core-contrib",
+                        "optional": true
+                    }
+                }
             }
         },
         "meta-yocto": {
@@ -32,7 +44,13 @@
                     }
                 },
                 "branch": "whinlatter",
-                "rev": "whinlatter"
+                "rev": "whinlatter",
+                "extra-remotes": {
+                    "contrib": {
+                        "uri": "ssh://git@push.openembedded.org/meta-yocto-contrib",
+                        "optional": true
+                    }
+                }
             }
         },
         "yocto-docs": {
-- 
2.53.0


