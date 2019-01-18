Return-Path: <kergoth@gmail.com>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail.openembedded.org (Postfix) with ESMTP id 3B0977C26B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jan 2019 16:46:04 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id c14so15897191wrr.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jan 2019 08:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=eZ7boBqB0bpi3mfsEcE/Ww6uzIHUmHYPWeePDoMxPpI=;
	b=dnT2lU1yT+7dQYEFQq45ua1lJjeooFwf5opwgHHQ/4jJRMv7byxjnwfHlBEFAL6TdJ
	P5mu8k8ebaY/mX2LvLvdYZpywGum4p7aW7WdQy3pXoNG3L122drDr0bNgt1tF0JHXqlA
	Mn7dQEqsnr7QHMKYJkhDckPycTtNdQ4C7GJ2ttF0c+xqJRgR4bUxQTnhRGojIfJb1K5N
	Pcor9M2Fxja4rFZr8iyZc85sGRGZ7iDrBnDoX63z+9D2An8cAasKi0155FS0EyXla1WF
	tLao+bLz+vyCayFSr2eelOxgYjGloIwLWTO1oYETZmF0kHfSD1sQYLns/PHvy64FreM8
	St5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=eZ7boBqB0bpi3mfsEcE/Ww6uzIHUmHYPWeePDoMxPpI=;
	b=c6JnJUxQW7DpQ5v1VMZS4DD3sbajv9ZudTVNt8c9zqxfYj2T0BBsz8B7U0gWGrg0UK
	J6ZLS0Z0DLmpQrFptx8cX1eCpeEm9YoQeiTWtUa3gOuwJn+mwXaRGZra/HIF0Qj3oVD+
	L/+fWZcIIALsPgPGwe5FPqeYGB/20EaV/Sk40vq8hQ+ihUdehv1bZKZxyievAdVIBroI
	sA2ikQrUVDXiabChwqg7C+8CBmHza1UfJZYhL8LHBWIBg2dFb76rCgs33/m39coh3BxG
	jSZzcPQTa/8SXUzySlHcRcp53k+PToFM139xn5EoIQ67QiaAPUEn5VnELIaSq9F4wFve
	YD/w==
X-Gm-Message-State: AJcUukdLcnUf849d8z0f5tPHmOtXQJ3urUzfxlujmLfoYqJo7k8LtjPo
	747kwN6G++HsFp9TXrFSS+78XGv3
X-Google-Smtp-Source: ALg8bN42BC00MebdtLhLmeQEdkgq0YFzIMot/xq0SABAh6gyn7LTbIfqo0AKDvAKA/DPC+gCD8tllA==
X-Received: by 2002:adf:e846:: with SMTP id d6mr17806827wrn.72.1547829964601; 
	Fri, 18 Jan 2019 08:46:04 -0800 (PST)
Received: from svr-pkl-eng-07.mgc.mentorg.com ([110.93.212.98])
	by smtp.gmail.com with ESMTPSA id
	b7sm78523175wrs.47.2019.01.18.08.46.02
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 08:46:03 -0800 (PST)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 18 Jan 2019 21:45:54 +0500
Message-Id: <cc654ea8c3a07c03fcc28ef199b8990a64555fe9.1547829050.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <cover.1547829050.git.chris_larson@mentor.com>
References: <cover.1547829050.git.chris_larson@mentor.com>
In-Reply-To: <cover.1547829050.git.chris_larson@mentor.com>
References: <cover.1547829050.git.chris_larson@mentor.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 1/2] bb.data_smart: only try to expand refs to valid variable names
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
X-List-Received-Date: Fri, 18 Jan 2019 16:46:04 -0000

From: Christopher Larson <chris_larson@mentor.com>

This aligns the behavior of expansion with the recipe parser, only
attempting to expand references to valid variable names. This avoids
adding references for things like `${foo#${TOPDIR}}` to our vardeps
without imposing much additional processing overhead beyond the change
to the expansion regexp.

YOCTO #12987

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/data_smart.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 1f45cd97..07db7be9 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -40,7 +40,7 @@ logger = logging.getLogger("BitBake.Data")
 
 __setvar_keyword__ = ["_append", "_prepend", "_remove"]
 __setvar_regexp__ = re.compile(r'(?P<base>.*?)(?P<keyword>_append|_prepend|_remove)(_(?P<add>[^A-Z]*))?$')
-__expand_var_regexp__ = re.compile(r"\${[^{}@\n\t :]+}")
+__expand_var_regexp__ = re.compile(r"\${[a-zA-Z0-9\-_+./~]+?}")
 __expand_python_regexp__ = re.compile(r"\${@.+?}")
 __whitespace_split__ = re.compile(r'(\s)')
 __override_regexp__ = re.compile(r'[a-z0-9]+')
-- 
2.17.1


