Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
	by mail.openembedded.org (Postfix) with ESMTP id 0EF2B7061F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jul 2014 12:15:05 +0000 (UTC)
Received: by mail-wg0-f51.google.com with SMTP id b13so3409686wgh.10
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jul 2014 05:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=WH77oIsA/sft9BaeFNaVTgltDwtAXW1KwAKP5ISct1Q=;
	b=VeC2XF90AJBEc7oLL/hRS6oJGJ4Ry/gUlAt+QKSz7rP2r+cQMQI7pnrpIyv2TsDvY4
	piHI/gIvaBbUBnRbjseLvoWSDq2WwNdDnTDRCG06iS/VLhbmOHvIzsh7B+xFRjZRyiJo
	hfW2SXnxQpQ17C51YHaM1Jok+AOX5cvhfgGkfiINhPqxp0ftjLWroZ6LWowIa5IhBSIx
	uXmg4e7jxepG29lM93eL+vgElMjXXzitZyyAVtO6h5a+5SbyP8FRCiQw6xAt5k7E7w8E
	zuTTdFdlLH94qxHLFRw4liltPGMnXtyT6chbCn7viYauqFCt8uObcYogG3du42pGrn1g
	dI5g==
X-Gm-Message-State: ALoCoQncobKZCNeQZPqteuHfbkt/W8frH4c6Lg3/kXWJc8WWaeFqtrsMifcTbFTmI6LaPCOZAa5D
X-Received: by 10.180.98.130 with SMTP id ei2mr31496214wib.24.1405685706216;
	Fri, 18 Jul 2014 05:15:06 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id fu7sm6158596wib.2.2014.07.18.05.15.04
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 18 Jul 2014 05:15:05 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id D82585603FC; Fri, 18 Jul 2014 13:15:02 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@yoctoproject.org
Date: Fri, 18 Jul 2014 13:15:00 +0100
Message-Id: <e8009c53f28f125139ac04f7ae720d22b2a05e9e.1405685308.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <a487f31bcfa47e1a48cb4bc122017ccb5e8b8f1a.1405685308.git.alexandru.damian@intel.com>
References: <a487f31bcfa47e1a48cb4bc122017ccb5e8b8f1a.1405685308.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1405685308.git.alexandru.damian@intel.com>
References: <cover.1405685308.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 6/8] document requirements for the python environment
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
X-List-Received-Date: Fri, 18 Jul 2014 12:15:06 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Since Toaster adds a number of specific requirements managed
by pip, we document these requirements in order to be able
to run bitbake and toaster under virtualenv. The target here
is to break the dependency on distro packages for specific
python libraries.

In order to start bitbake/Toaster in a distro-independent manner,
we use virtualenv and pip. We add venv to the .gitignore list
to make room for the virtualenv deployment in this directory.

Use this command sequence to setup the virtualenv:

$ virtualenv venv
$ . venv/bin/activate
$ cat requirements.txt | xargs pip install

bitbake and Toaster will then run normally under virtualenv.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 .gitignore       | 2 ++
 requirements.txt | 4 ++++
 2 files changed, 6 insertions(+)
 create mode 100644 requirements.txt

diff --git a/.gitignore b/.gitignore
index 5d9bc50..5adf4d1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -7,6 +7,8 @@ pyshtables.py
 /bin/bitbakec
 *.swp
 tags
+*.sqlite
+venv/
 doc/bitbake-user-manual/bitbake-user-manual.html
 doc/bitbake-user-manual/bitbake-user-manual.pdf
 doc/bitbake-user-manual/bitbake-user-manual.tgz
diff --git a/requirements.txt b/requirements.txt
new file mode 100644
index 0000000..2bb07e6
--- /dev/null
+++ b/requirements.txt
@@ -0,0 +1,4 @@
+Django==1.5
+South==0.8.4
+argparse==1.2.1
+wsgiref==0.1.2
-- 
1.9.1


