Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF315CD4851
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 10:58:55 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8099.1778756325741366559
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 May 2026 03:58:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=IRdgPIOj;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 071EF1A35A2
	for <bitbake-devel@lists.openembedded.org>; Thu, 14 May 2026 10:58:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D143960495;
	Thu, 14 May 2026 10:58:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7F1CC11AFA05C;
	Thu, 14 May 2026 12:58:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778756323; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=VCd3Bxo3KVKah4UaafuZvLTXuboenslTEFgArk9Fb3Q=;
	b=IRdgPIOjyFPG6LyetGckjQ+dmUzv5choJgvf5zUC0YlHR1TLsAtJJSVzh9ar9HFF2Olnkc
	cwJjC19PwrIDWO4AYXkLrlola2M0ff2/wIAU7ctFJs1MsLlJf4/8N/CHpkM7I0pTK2rrBu
	IQ21FnrWby3FlV/KCZ+L0blKdDEQK0C07EBeMrNbYVJVDOVtjtcyqtbEkKQ5ut75QSmeBc
	jnk9qffqMRvDVvy0CQhbFJXCVjAb1mxVe/wva38OA+7u++b9ty29OIJQjoIv/VavRg17oD
	Yo1NAhTTjr51Xr+AlkveiRT9wCnb8Kedrd62pc2hxIrJhlVqmj7ckgBqm/SfeQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 14 May 2026 12:53:15 +0200
Subject: [PATCH 2/2] doc/setversions.py: use older lts series to check tag
 existence
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-set-versions-fixes-v1-2-70b1fcdda8ee@bootlin.com>
References: <20260514-set-versions-fixes-v1-0-70b1fcdda8ee@bootlin.com>
In-Reply-To: <20260514-set-versions-fixes-v1-0-70b1fcdda8ee@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=908;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=o3u2I34lMFRXZi+YZ1KgDByPhMRDF3yC3XWsMAAaPoU=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBqBarAWucjO7ln4AX+iuO7Br2iDW4zpq0ooV/Ly
 SRLkXUkrW+JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCagWqwAAKCRDRgEFAKaOo
 NsTxD/0SSoWAsxDAN/a0KvhopO523zc1pJv7P+G8aHslsOXUVbvA5Q619mzBMobl+4fgSqKK4GH
 M6b0j7CHMPklK5yXIHExuTBdGjy6RU6yHPXwJRKZLwOWt38C5akx2Q4FZD7jQu2ItPFWapfWaNi
 zhNPf0IWXeyVYir3E6pdCq9WVDgX7wre/BUoqIAf2qF0Rik/tYhV7rSe4XSFanOXep36COPGZer
 q5O/2NUIWuI12Q6UVfx4gTw9ZPFARenJrnhK/M+oVIF5YdspqM685Kn3MaDsIulveGKTHokJPGu
 uyjRTyctpT5AP053fQqegJongQttGyebaclPyNIfzSdUj/tDkOHjDNISpVb9Dk91Z66rA1RnayB
 8KDKBuX94MFnlJpc/KcOtqBgSwn4DM6HOnpnB2HqdvSP660wDt0FsxXYZ3BMCCCDuh0A8JQYXk2
 qtBRXdgDVTb0OnmnMX4UT6ngsvUTVcwe2K506hITyziGNQeP7xUadehF4s/Q9quecyoW0YDoqNR
 O5AzoPvUgh0g8+9RizixBhl8wXb8LUNIPenKeL5XCg9AjIrvorlgx3uApl1vDq70p8u9YYwhMvE
 vdO80A0fP71XflWoaB+uLJIYrDkYxGIukK74/rXwPYnXWKJXI5TTzBTET9UeJeF1qH06NYUyH9c
 i7FMg8wNMXJnJZQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 May 2026 10:58:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19521

Using the most recent LTS series to check if a tag exist may fail if the
LTS was recently created. Use the older one instead.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/setversions.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/setversions.py b/doc/setversions.py
index 8e934667f93..2df384e9117 100755
--- a/doc/setversions.py
+++ b/doc/setversions.py
@@ -109,7 +109,7 @@ def main():
 def get_current_version():
     # Test tags exist and inform the user to fetch if not
     try:
-        subprocess.run(["git", "show", f"{LTSSERIES[0]}.0"],
+        subprocess.run(["git", "show", f"{LTSSERIES[-1]}.0"],
                        stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=True)
     except subprocess.CalledProcessError:
         sys.exit("Please run 'git fetch --tags' before building the documentation")

-- 
2.54.0


