Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id 268F975AD8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 10:35:14 +0000 (UTC)
Received: by wgqq4 with SMTP id q4so58761790wgq.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 03:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=xF3bZkCqTsAwbAlO0J4BZaYmPEyr2h0xMr43CT5Yqgs=;
	b=mUxBawMzL23LFxNM9oJNYpcb3gKVmRgJ+D3hWV4pG73v/rtGvlrn+/QMXXq+TJ2oLq
	mVtn211T3j/PSTEKoIPIAOor9PBqInCx2NiDDhtGqxpf3W0OlfLBR8/m7t53xjAYxlKV
	+5DGzlfjzYFuiNIxM5uLnMpKxw3asJaNkOCDnknfsfcj7lMeE/Xh1ZCMhDtAxEPDjEZ7
	ZT8jbErArIC3WIwLfnvSvpXAKPTdonXuEDQVIxttO139zNROen/CW7FsC4hpPfNf6+bN
	mCI3L/VXpyhj8Xb21XvhvqIAYhfgHqb48ycpPKrzQ4ByXb5tRY7Rye4bTGP8O9bRqDp0
	u29g==
X-Gm-Message-State: ALoCoQl3ZUh55Z3JTNeTSp3TGMz53RPMF0D01qU4nWBzV/kT62nGYy2pGTLUivxJ2IJRwSD25WL1
X-Received: by 10.194.57.211 with SMTP id k19mr79610583wjq.53.1435228515806;
	Thu, 25 Jun 2015 03:35:15 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id u7sm6940250wif.3.2015.06.25.03.35.14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Jun 2015 03:35:14 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id E6AAF562BB3; Thu, 25 Jun 2015 11:34:01 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Jun 2015 11:33:58 +0100
Message-Id: <2f74ff59f2873c1cf121f7a385f3ab971c793a9c.1435228176.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
References: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1435228175.git.alexandru.damian@intel.com>
References: <cover.1435228175.git.alexandru.damian@intel.com>
Subject: [PATCH 21/23] toaster: bldcontrol Ignore toasterconf files in own directories
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 25 Jun 2015 10:35:15 -0000

From: Michael Wood <michael.g.wood@intel.com>

If toaster has previously cloned poky or a layer with a toasterconf
file we don't want this to be picked up as a choice as these clones are
"internal" to toaster and may have undesired effects on toaster's setup.

[YOCTO #7741]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/bldcontrol/management/commands/checksettings.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/toaster/bldcontrol/management/commands/checksettings.py b/lib/toaster/bldcontrol/management/commands/checksettings.py
index 3c52446..3002e4c 100644
--- a/lib/toaster/bldcontrol/management/commands/checksettings.py
+++ b/lib/toaster/bldcontrol/management/commands/checksettings.py
@@ -166,6 +166,8 @@ class Command(NoArgsCommand):
                             conffilepath, error = subprocess.Popen('bash -c ". '+os.path.join(dirname, ".templateconf")+'; echo \"\$TEMPLATECONF\""', shell=True, stdout=subprocess.PIPE).communicate()
                             conffilepath = os.path.join(conffilepath.strip(), "toasterconf.json")
                             candidatefilepath = os.path.join(dirname, conffilepath)
+                            if "toaster_cloned" in candidatefilepath:
+                                continue
                             if os.path.exists(candidatefilepath):
                                 config_files.append(candidatefilepath)
 
-- 
1.9.1


