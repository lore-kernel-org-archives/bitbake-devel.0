Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
	[209.85.220.47])
	by mail.openembedded.org (Postfix) with ESMTP id 77961732E3
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 18:02:11 +0000 (UTC)
Received: by mail-pa0-f47.google.com with SMTP id lj1so35230825pab.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Feb 2015 10:02:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=3OMUTJx+0ZQirdRPcYGuQ0bK8wBIMAStKFXkz7X21uo=;
	b=O4jSLvhlDGwwDPYJub0nomJLeQnkSMYlx5eaNTh6mJmcSRISxj1QCoqkrQzVIQvXKE
	9pctKUgkkHgy6MG2kmN3apiMogNjPFDIZapIvKMUVhcMWol6KQHSuoO1wBAJ9nsQjAqI
	JLzHtKr5K/Lm6FA+jzLUtNf7yUgpcbPqyR8Zkfrbvk0NPNRhHOOM+8U0NfeLxrz+2Iie
	RV/2QEkV9aMEY0saEjQUIH9TCA+0L9HKRGQxnigXqn2yyxJPwckDqDTCdIb3OusRApOj
	Og9Yf9b61CrgNr05Q90GoJS7uHJMHQuyUIhd1MrRv/Wq2dJMe3fyS1PXcukl5d71Jv9k
	N4sA==
X-Gm-Message-State: ALoCoQkLr1Waho1g1FHHMirsfg75hHVisUb/VLohbmtYKNFW+zXR/sljUA+FzP+AhdoJOnZ4ZVy1
X-Received: by 10.66.139.167 with SMTP id qz7mr31491593pab.50.1423504932928;
	Mon, 09 Feb 2015 10:02:12 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id rf9sm17123789pab.0.2015.02.09.10.02.10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 09 Feb 2015 10:02:11 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 65E415661BF; Mon,  9 Feb 2015 18:01:58 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Feb 2015 18:01:51 +0000
Message-Id: <0a2e0194fe7d949f1e9e01f7b42a7e0dc7a223f5.1423504574.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
References: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1423504574.git.alexandru.damian@intel.com>
References: <cover.1423504574.git.alexandru.damian@intel.com>
Subject: [PATCH 21/27] toaster: models Allow the machine's layer name to be searched
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
X-List-Received-Date: Mon, 09 Feb 2015 18:02:11 -0000

From: Michael Wood <michael.g.wood@intel.com>

Make the layer name searchable. If you know the name of the layer you are
interested in, searching for it is a fast way of getting the list of
machines provided by it.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/models.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index ad7a856..4bb84bd 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -529,7 +529,7 @@ class Recipe_Dependency(models.Model):
 
 
 class Machine(models.Model):
-    search_allowed_fields = ["name", "description"]
+    search_allowed_fields = ["name", "description", "layer_version__layer__name"]
     layer_source = models.ForeignKey('LayerSource', default = None, null = True)  # from where did we get this machine
     up_id = models.IntegerField(null = True, default = None)                      # id of entry in the source
     up_date = models.DateTimeField(null = True, default = None)
-- 
1.9.1


