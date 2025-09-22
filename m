Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C43BCAC592
	for <webhook@archiver.kernel.org>; Mon, 22 Sep 2025 14:07:30 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.52895.1758550046689405833
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Sep 2025 07:07:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=AO2kqPJt;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3eebc513678so2832059f8f.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 22 Sep 2025 07:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758550045; x=1759154845; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Roh1vznEyMhvnS076RfixdnDKz313zMrrYPvn2pl3hM=;
        b=AO2kqPJtquGWd/NnBPHjFVZq3xgI8TZ86yssQA2lEX9uL+e3qsIE0sgCAWPlc7tO9Z
         4q8FKcp6UpBB7Kf5ThrPQbtCFEWVPHhbQJpuoKQCHAwibNhdFAbTr6pdaCBVYlSJ+uRr
         w0lnCudCc4OcCgi07ss9Nbu8HW1+F42vvjkI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758550045; x=1759154845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Roh1vznEyMhvnS076RfixdnDKz313zMrrYPvn2pl3hM=;
        b=t1Q9LDFM9k696SRYQzEqFS4jfc5IRXVfBsYBvWyt5yG5t73Bthkzwmh/cdI/m3f/yB
         QAiVgNcsBvtnBElpxgD9pBIVy6haNQZc05XGDw4OvBsT5mX/lgjkkOkW7Nd+DpklnuAh
         b4+xGgqkt6zuapzeogsEuK3rzWPGGO+n6/Ov9vXgHW0MCWrbLoSYm3Ywft6c63QwoU0f
         vCqrZeTwtBvTgYMRlYH7vApH8RpHHfQ/Nq/hQ8ZDDPiOmYGW913ijl2OJLpwNmuu1SPB
         H5pTrF7V05UmhVlzXb7JioeE1F6bz0BeXjJ4XW/np0QYpx0TLrFo+DI6LsJhmY5wFbu5
         gBkA==
X-Gm-Message-State: AOJu0YwB6su1Bcsr/PxIDo3rzKTtTNFrsZUkF70J7nxGooxNFygtw1zA
	fvrZxwOG2OwDXJ44OWVTEqaOWLx1+MkfdEtE0MgkGrW/Gkq4AhZXgsnkxZgUwzDvq/Zr5gfFfhI
	E6hdO
X-Gm-Gg: ASbGncvFXPC8RdGJ3Pf5YtHdfJzqDLNFNLKJ+AvR3Qlod6HcXJgeHK11qXY7vnvWKii
	eF/jCaF9NzOjLoE507I1OmtXbPlPmFIJVnrwNI0vrs5bOHo4iRCx67m0tWxMGGOF83skCNajOw4
	PzpdkDhph1v3xDe9NUV9fh9j+UtDAkVlWT/yDpY/AsOyfSNIcfMKMQnbMKH1YObKpXj6Nir8xuU
	2djeIT2VC5T/28Dk1m012+usWT16CvU2lX/bxI4mVGKVvLyUbyRl22SA43R5sPvfX7HgO76oIcA
	jw2MtFIzpEcae5d8czpy1UQSSzorIFoJA0NkqNNUrwIUppLnG5y5vOjOswm34ABnhv3X9vE23ZZ
	4PQ+mhMunsk4hKHbf3U2DnWXb44uvWuUChwI+5IrEnZ93+M7vU0M=
X-Google-Smtp-Source: AGHT+IE6BGUBM8S5ShC0nIhV6d/gI3VfR386IbPBu4QNN/RqxDk1ABRadI+Twc2DEYvSsqOnHri/6w==
X-Received: by 2002:a05:6000:178a:b0:3c7:36f3:c352 with SMTP id ffacd0b85a97d-3ee86d6cd65mr11649477f8f.59.1758550044572;
        Mon, 22 Sep 2025 07:07:24 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:2639:6647:8a82:45d2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7107sm20939516f8f.30.2025.09.22.07.07.23
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 07:07:23 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/3] Add default registry config for OpenEmbedded's nodistro and Yocto Project's poky
Date: Mon, 22 Sep 2025 15:07:20 +0100
Message-ID: <20250922140721.2266610-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250922140721.2266610-1-richard.purdie@linuxfoundation.org>
References: <20250922140721.2266610-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Sep 2025 14:07:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18071

Rather than forcing every user to have to access a separate repository
for data for some key defaults, add those for nodistro and poky. This
gives us some commonly used setups and also something to test against too.

We will need to come up with a criteria for adding these, most likely based
on community usage/demand with the OE TSC governing that policy.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../configurations/oe-nodistro.conf.json      | 54 ++++++++++++++
 .../configurations/poky-master.conf.json      | 70 +++++++++++++++++++
 2 files changed, 124 insertions(+)
 create mode 100644 default-registry/configurations/oe-nodistro.conf.json
 create mode 100644 default-registry/configurations/poky-master.conf.json

diff --git a/default-registry/configurations/oe-nodistro.conf.json b/default-registry/configurations/oe-nodistro.conf.json
new file mode 100644
index 00000000000..f4a7492f39e
--- /dev/null
+++ b/default-registry/configurations/oe-nodistro.conf.json
@@ -0,0 +1,54 @@
+{
+    "description": "OpenEmbedded - 'nodistro' basic configuration",
+    "sources": {
+        "bitbake": {
+            "git-remote": {
+                "remotes": {
+                    "origin": {
+                        "uri": "git://git.openembedded.org/bitbake;protocol=https"
+                    }
+                },
+                "rev": "master"
+            },
+            "path": "bitbake"
+        },
+        "openembedded-core": {
+            "git-remote": {
+                "remotes": {
+                    "origin": {
+                        "uri": "git://git.openembedded.org/openembedded-core;protocol=https"
+                    }
+                },
+                "rev": "master"
+            },
+            "path": "openembedded-core"
+        },
+        "yocto-docs": {
+            "git-remote": {
+                "remotes": {
+                    "origin": {
+                        "uri": "git://git.yoctoproject.org/yocto-docs;protocol=https"
+                    }
+                },
+                "rev": "master"
+            },
+            "path": "yocto-docs"
+        }
+    },
+    "bitbake-setup": {
+        "configurations": [
+        {
+            "name": "nodistro",
+            "description": "OpenEmbedded 'nodistro'",
+            "bb-layers": ["openembedded-core/meta"],
+            "oe-fragments-one-of": {
+                "machine": {
+                    "description": "Target machines",
+                    "options" : ["machine/qemux86-64", "machine/qemuarm64", "machine/qemuriscv64"]
+                }
+            }
+        }
+        ]
+    },
+    "version": "1.0"
+}
diff --git a/default-registry/configurations/poky-master.conf.json b/default-registry/configurations/poky-master.conf.json
new file mode 100644
index 00000000000..227816983b5
--- /dev/null
+++ b/default-registry/configurations/poky-master.conf.json
@@ -0,0 +1,70 @@
+{
+    "description": "Poky - The Yocto Project testing distribution configurations and hardware test platforms",
+    "sources": {
+        "bitbake": {
+            "git-remote": {
+                "remotes": {
+                    "origin": {
+                        "uri": "git://git.openembedded.org/bitbake;protocol=https"
+                    }
+                },
+                "rev": "master"
+            },
+            "path": "bitbake"
+        },
+        "openembedded-core": {
+            "git-remote": {
+                "remotes": {
+                    "origin": {
+                        "uri": "git://git.openembedded.org/openembedded-core;protocol=https"
+                    }
+                },
+                "rev": "master"
+            },
+            "path": "openembedded-core"
+        },
+        "meta-yocto": {
+            "git-remote": {
+                "remotes": {
+                    "origin": {
+                        "uri": "git://git.yoctoproject.org/meta-yocto;protocol=https"
+                    }
+                },
+                "rev": "master"
+            },
+            "path": "meta-yocto"
+        },
+        "yocto-docs": {
+            "git-remote": {
+                "remotes": {
+                    "origin": {
+                        "uri": "git://git.yoctoproject.org/yocto-docs;protocol=https"
+                    }
+                },
+                "rev": "master"
+            },
+            "path": "yocto-docs"
+        }
+    },
+    "bitbake-setup": {
+        "configurations": [
+        {
+            "name": "poky",
+            "description": "Poky - The Yocto Project testing distribution",
+            "bb-layers": ["openembedded-core/meta","meta-yocto/meta-yocto-bsp","meta-yocto/meta-poky"],
+            "oe-fragments": ["core/yocto/sstate-mirror-cdn"],
+            "oe-fragments-one-of": {
+                "machine": {
+                    "description": "Target machines",
+                    "options" : ["machine/qemux86-64", "machine/qemuarm64", "machine/qemuriscv64", "machine/genericarm64", "machine/genericx86-64"]
+                },
+                "distro": {
+                    "description": "Distribution configuration variants",
+                    "options" : ["distro/poky", "distro/poky-altcfg", "distro/poky-tiny"]
+                }
+            }
+        }
+        ]
+    },
+    "version": "1.0"
+}

