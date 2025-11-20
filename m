Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137F7CF9C46
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 16:24:57 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.646.1763655887103702698
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Nov 2025 08:24:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ha+P7d/o;
 spf=pass (domain: gmail.com, ip: 209.85.218.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7277324204so179262966b.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 20 Nov 2025 08:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763655885; x=1764260685; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dJC88YIz01FddSZC55M5g2IPziqw9knMYDIImYjKEzI=;
        b=ha+P7d/oADn/0ADXD7F/8qmNfBxTYKNf0IXT+GGgYAOCnk4/AGZMLQweQ0Nz++voZL
         Z75hDLotMdDWtuGCKj4SUnxWfyiQaZPFClzdo/xzwnEdBheUJV9avO5hO8+ZhT9VbXZ7
         3JnHcG23HppawWiLgDpFevqWsvwPbL3zjD9Z12HNl5oqx8yE5MubfhM/GrSbrKydszZ+
         7RB37Ab0UeSzl+9brFU8GvgTkN+WoF6TVfmkbjCLFIuGgL4A51eo84CYWhfr5IsLx0LR
         2CKP0QZZhlRgYdZZ8BqJhGHPIwlFOqD6x08PuAOC/3NO5qI8v1zIgPusDr7EQUgmBxXE
         ebrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763655885; x=1764260685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJC88YIz01FddSZC55M5g2IPziqw9knMYDIImYjKEzI=;
        b=o9tWe7fYTBh41R+lWGlAiPSSMRDcIi6PWn0x/VI3n4YHnkwKdbCJ/MG/OxGKaGaMY1
         i9ptZ3g+AIlwRub9FuUHbfR+mb+/NZQWY2PphtKx97TolidbjlLK5k8lxbTgT54fqb12
         TwgdQx6CR0EHQNYZmNvKX0ssEDwe90jrSK+kelzrhlWjr8uELme60AYSmn5FlNmJ6a70
         XHTVovppdzillAcyx6LGlrvT+gIKIZsJuPNYcLQp34PBK3d1iA28PPMhh8mR82hQmNVH
         hqq3cIi7t6PA4q6TApovsiZnG6OLlCG4IXpSXn20BNMcDV2riMiP5K6QtBURjDdBriYx
         dOeg==
X-Gm-Message-State: AOJu0YymRwuGBI9WOEATCFdavQLq38lgSMPH9DPaStLGTQd2jf4zRfek
	BMJHE5i+Tzuf/Vsqby0MLpB/AvqmILDYezvP1s8ALPud/PJ2l+R/jEGPlbufxg==
X-Gm-Gg: ASbGncu00lwb90KjbaifZT2qaZaZSUH7YAiqQ/NuVaFSEySQN9qsoC50vP/l3y6Bfpd
	y7H0y5qKnVqwMX2B2UWFu4VRqeLgRhqBWafjYrR54fIVJBdTlUPU6SbthbgV6yBbTP7X8zy5nqZ
	3TskMYXYyStfUDWBEGE6exOGakj/HPhceQKckX1nbX+PUbCE0sCdcdiyMOEu7AVkN819iXtZt28
	UTOtPuU2uXMOjksdObUB9GsBq08rMNFtqL+dMS3osVBMJu/+0udO88QoMXZcovKkA9KNiWR475t
	/wDxQ00L9hqZhO7fALSy9NRG4py/bTduHOnbwyH8zlePfghb18BU0eeNYZuJ+BXhxwFA+g16LWa
	1HJm/iF5hsQkSbo8KcDUb4sIQIMeccHNQzE7ZZ8n6FQkjsLL6ii/9Xkyv4Q4I981lNo1RK6xj4v
	hxafQcD0Sb82D52ii1QLEZIw0KWn27/u/es17oMu1ds4guakfhmqBSu2UddQ==
X-Google-Smtp-Source: AGHT+IEVQ7dkCKCBB9AQMdLWz3leOViRWMdaegFwffZJRNOW3WUiCpoU9J3FT3D5INOa4Q1bSmiXKQ==
X-Received: by 2002:a17:906:478b:b0:b73:5846:b78a with SMTP id a640c23a62f3a-b7654f838eemr395121766b.58.1763655885069;
        Thu, 20 Nov 2025 08:24:45 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654fd4fc4sm241022766b.43.2025.11.20.08.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 08:24:44 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] bitbake-setup: do not include prefix/ when using fragment names in setup directory variable expansions
Date: Thu, 20 Nov 2025 17:24:41 +0100
Message-Id: <20251120162441.218062-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Nov 2025 16:24:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18470

From: Alexander Kanavin <alex@linutronix.de>

Fragment prefixes are top level namespaces like distro/ machine/ yocto/
and so on; when constructing a setup directory name they are redundant
and add clutter. If necessary, they can be re-added directly into
the format string of the setup-dir-name parameter in the json config.

Particularly, the default setup dir names suggested by bitbake-setup
in default configurations look a lot better:

Before:
distro_poky-master

After:
poky-master

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 436456a47..75be90940 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -501,7 +501,7 @@ def init_config(top_dir, settings, args):
         setup_dir_name = "{}-{}".format(upstream_config['name']," ".join(upstream_config['non-interactive-cmdline-options'][1:]).replace(" ","-").replace("/","_"))
         if 'setup-dir-name' in upstream_config['bitbake-config']:
             mapping = {
-                    k: v.replace(" ", "-").replace("/", "_")
+                    k: v.partition("/")[2].replace(" ", "-").replace("/", "_")
                     for k, v in upstream_config['bitbake-config']['oe-fragment-choices'].items()
             }
             config_setup_dir_name = string.Template(upstream_config['bitbake-config']['setup-dir-name']).substitute(mapping)
-- 
2.39.5


