Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479DCD77896
	for <webhook@archiver.kernel.org>; Fri, 23 Jan 2026 17:24:39 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.639.1769189069455024374
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Jan 2026 09:24:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=AOek/Xav;
 spf=pass (domain: smile.fr, ip: 209.85.221.43, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-432d256c2e6so2441360f8f.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 23 Jan 2026 09:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1769189068; x=1769793868; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ma4NVhkjtSUmoFMFBl/xlOWpNKtRTxHX3lfQZzkESI=;
        b=AOek/XavvAAI7bC4cB2+X0hle3MIAN5YAx8KrHdfkS6ywFC1KH80SsNESDDZa+qFFn
         qyMrJWdBFElGbJs5rOM8yWG5U7s9zCAsnBTwAuh053yo528ez5NVfVaRp20dF+0hCdDT
         p76ddxccjsaAVrJ9PFomY/6RGsaZ5/vSdrgZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769189068; x=1769793868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ma4NVhkjtSUmoFMFBl/xlOWpNKtRTxHX3lfQZzkESI=;
        b=W+cuiPyqg3nacQAjMZjzmsr0ww7s1W57HEsPFdvGAEbQDLedwXGxjoVrLoEVP1i++p
         U8dlA8mvrO0eigUBl1n1ojz5+rlFYorArEeAe5rhKo1IhexnlBe6PJUPwhWGSb93769R
         1zhkqg75Y5jZbJ6N1IAaF6JNJJQSAEC0jDs5dqobvDuLs+Ri/5HN5ZMmUfxuC/L1oJAk
         8Xgyc38qjcViDXX3SYHY0wPg8sNOw2+UbgVEEiGv2FjE7G+/KyKora4nAbxwUI3hS9qY
         Tv8ukB8ZDWcfpM93ULw511FrPafO1VzbXSayp1pBaDvLeN4Ne0M6vaUYop4PqpVVdoTu
         GMDA==
X-Gm-Message-State: AOJu0YxCwODTa0ivmQqSWLdR77+nD3f/zD1BmkM/ykNlPkXNzsFiEnBY
	dwqvt9AkzvUTeFFaFgD6kYtBcmoilV9KonxUmoVWL/97UTHDhz94QaRtXJjNkZIlzYhodgAb8GE
	3nKiLSV8=
X-Gm-Gg: AZuq6aIBf+2iCihKDPNXOSahoci3JtqvNXzZhLSpXkCGdwtMoo1xp+XhlxuUANX0/d4
	ngHBhuxbDqumdLJDTppgeDpagwIO0OsyMEhmhyMXbqCC0wV44tnAEtvgijkbESo/jCrOwPgnwQ3
	1dZl225InQEpZ9o2eBMEt6NVgxhF/WYuEHP6WfJSm47VF+/qVIQA0bN1NIoxgHjNDLQMQ10Tepb
	HeNsJEkOsvjj1SH3GuaQQb4znuALh53wxRHWUtJWYIS66uM8QH0+psFezusUsGZYpk+Qpw4v6zG
	bjR4CaHZ0HH8yR3AYt9z6pwLBtvcGYsPMernLRce1X4iUj758ralwxhUl1eyVsbCt/kWAuPl9Mv
	c+UV+My1TNKPc4T2cvWkaQtN+X2AuqTWlYSggEmHNwLpAyaFnJnrEdI8sqcTApAk9PP7tck/G8t
	QRebrhPHSuDCjdehOfgY1za0UTPfoxyT/NYb05SYKVQE8zU7bdQcdKhDso1RIBdgyIbKkzAAImK
	7VaxHCrxZCp8OcecMEI
X-Received: by 2002:a05:6000:290c:b0:435:9ee1:f91a with SMTP id ffacd0b85a97d-435b16077e5mr6962485f8f.53.1769189067817;
        Fri, 23 Jan 2026 09:24:27 -0800 (PST)
Received: from heaven.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e715bfsm8664209f8f.22.2026.01.23.09.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 09:24:27 -0800 (PST)
From: Corentin Guillevic <corentin.guillevic@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH v6 3/4] bitbake-setup: use URI shortcut for all configurations
Date: Fri, 23 Jan 2026 18:24:21 +0100
Message-ID: <20260123172422.3304682-3-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123172422.3304682-1-corentin.guillevic@smile.fr>
References: <20260123172422.3304682-1-corentin.guillevic@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 23 Jan 2026 17:24:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18866

Currently, no source has several remotes. So we can replace their entire
structure 'remote' -> 'origin' -> 'uri' with a shorter one (property 'uri'
only).

Signed-off-by: Corentin Guillevic <corentin.guillevic@smile.fr>
---
 .../oe-nodistro-master.conf.json              | 18 +++-----------
 .../oe-nodistro-whinlatter.conf.json          | 18 +++-----------
 .../configurations/poky-master.conf.json      | 24 ++++---------------
 .../configurations/poky-whinlatter.conf.json  | 24 ++++---------------
 4 files changed, 14 insertions(+), 70 deletions(-)

diff --git a/default-registry/configurations/oe-nodistro-master.conf.json b/default-registry/configurations/oe-nodistro-master.conf.json
index 180d2008a..e4e842177 100644
--- a/default-registry/configurations/oe-nodistro-master.conf.json
+++ b/default-registry/configurations/oe-nodistro-master.conf.json
@@ -3,33 +3,21 @@
     "sources": {
         "bitbake": {
             "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "https://git.openembedded.org/bitbake"
-                    }
-                },
+                "uri": "https://git.openembedded.org/bitbake",
                 "branch": "master",
                 "rev": "master"
             }
         },
         "openembedded-core": {
             "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "https://git.openembedded.org/openembedded-core"
-                    }
-                },
+                "uri": "https://git.openembedded.org/openembedded-core",
                 "branch": "master",
                 "rev": "master"
             }
         },
         "yocto-docs": {
             "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "https://git.yoctoproject.org/yocto-docs"
-                    }
-                },
+                "uri": "https://git.yoctoproject.org/yocto-docs",
                 "branch": "master",
                 "rev": "master"
             }
diff --git a/default-registry/configurations/oe-nodistro-whinlatter.conf.json b/default-registry/configurations/oe-nodistro-whinlatter.conf.json
index 7b183ae1c..8342f2cf5 100644
--- a/default-registry/configurations/oe-nodistro-whinlatter.conf.json
+++ b/default-registry/configurations/oe-nodistro-whinlatter.conf.json
@@ -4,33 +4,21 @@
     "sources": {
         "bitbake": {
             "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "https://git.openembedded.org/bitbake"
-                    }
-                },
+                "uri": "https://git.openembedded.org/bitbake",
                 "branch": "2.16",
                 "rev": "2.16"
             }
         },
         "openembedded-core": {
             "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "https://git.openembedded.org/openembedded-core"
-                    }
-                },
+                "uri": "https://git.openembedded.org/openembedded-core",
                 "branch": "whinlatter",
                 "rev": "whinlatter"
             }
         },
         "yocto-docs": {
             "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "https://git.yoctoproject.org/yocto-docs"
-                    }
-                },
+                "uri": "https://git.yoctoproject.org/yocto-docs",
                 "branch": "whinlatter",
                 "rev": "whinlatter"
             }
diff --git a/default-registry/configurations/poky-master.conf.json b/default-registry/configurations/poky-master.conf.json
index 1de038bab..82464e8ab 100644
--- a/default-registry/configurations/poky-master.conf.json
+++ b/default-registry/configurations/poky-master.conf.json
@@ -3,44 +3,28 @@
     "sources": {
         "bitbake": {
             "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "https://git.openembedded.org/bitbake"
-                    }
-                },
+                "uri": "https://git.openembedded.org/bitbake",
                 "branch": "master",
                 "rev": "master"
             }
         },
         "openembedded-core": {
             "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "https://git.openembedded.org/openembedded-core"
-                    }
-                },
+                "uri": "https://git.openembedded.org/openembedded-core",
                 "branch": "master",
                 "rev": "master"
             }
         },
         "meta-yocto": {
             "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "https://git.yoctoproject.org/meta-yocto"
-                    }
-                },
+                "uri": "https://git.yoctoproject.org/meta-yocto",
                 "branch": "master",
                 "rev": "master"
             }
         },
         "yocto-docs": {
             "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "https://git.yoctoproject.org/yocto-docs"
-                    }
-                },
+                "uri": "https://git.yoctoproject.org/yocto-docs",
                 "branch": "master",
                 "rev": "master"
             }
diff --git a/default-registry/configurations/poky-whinlatter.conf.json b/default-registry/configurations/poky-whinlatter.conf.json
index bfa67426d..80b3c7f8c 100644
--- a/default-registry/configurations/poky-whinlatter.conf.json
+++ b/default-registry/configurations/poky-whinlatter.conf.json
@@ -4,44 +4,28 @@
     "sources": {
         "bitbake": {
             "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "https://git.openembedded.org/bitbake"
-                    }
-                },
+                "uri": "https://git.openembedded.org/bitbake",
                 "branch": "2.16",
                 "rev": "2.16"
             }
         },
         "openembedded-core": {
             "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "https://git.openembedded.org/openembedded-core"
-                    }
-                },
+                "uri": "https://git.openembedded.org/openembedded-core",
                 "branch": "whinlatter",
                 "rev": "whinlatter"
             }
         },
         "meta-yocto": {
             "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "https://git.yoctoproject.org/meta-yocto"
-                    }
-                },
+                "uri": "https://git.yoctoproject.org/meta-yocto",
                 "branch": "whinlatter",
                 "rev": "whinlatter"
             }
         },
         "yocto-docs": {
             "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "https://git.yoctoproject.org/yocto-docs"
-                    }
-                },
+                "uri": "https://git.yoctoproject.org/yocto-docs",
                 "branch": "whinlatter",
                 "rev": "whinlatter"
             }
-- 
2.51.0


