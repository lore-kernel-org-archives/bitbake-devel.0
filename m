Return-Path: <dev@codyps.com>
Received: from mail-qg0-f54.google.com (mail-qg0-f54.google.com
	[209.85.192.54])
	by mail.openembedded.org (Postfix) with ESMTP id 40AE165C7B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Nov 2014 01:26:09 +0000 (UTC)
Received: by mail-qg0-f54.google.com with SMTP id q108so8180302qgd.13
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Nov 2014 17:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codyps.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=NC4uzmgWGsLV8nBl+Ng2nU58+gh1/TFgk5AZg5ksvfg=;
	b=V9tD22MpKfU00Si5ZsY1um5vDGhu7fWPXodqY8cTK7bcSsBkzDQb8qGvqeMAtUJz3v
	naDQBRV6kLyWFBmv0lctNMJNRnWlfldF2k8NetJvnPeKINbv5scBQaM5y+LsLzmvl6M2
	YtasEAIf2Xu6g8piKv1WXFxokX5/Z26lALf+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=NC4uzmgWGsLV8nBl+Ng2nU58+gh1/TFgk5AZg5ksvfg=;
	b=M1HQYIHtF6NhPfnRCVBq36oCEpwrG8I39NcZfT/KXsxkGOdR1aPkze82pBPjRylkXF
	6363aUPocxC02VPv89SrdVosaOQw/lke4MhQ0wvf5T1oCWPUZ26vnb4mkXCi0uqtNE+6
	C/WaIjxXDF1HvnpxcUTsTREyLEC1yOkHsgE8tLTguVNO+SUbs7ekEsZLBQKp6m1YbLzM
	/wXKCjYOyufa5Xs73TTF7CjOMwW11riYVT/AN8OBQizbUA+PvI9QUUVoqBeTfdrLtb1z
	v53Hy9fq2E879/byGMHhQECLdC/YSAlDKJoxZem1xhvqUA5oBoQa38CybGYVnd3OgZqY
	DlvA==
X-Gm-Message-State: ALoCoQnOB9pFULUt2rVnXohQVhZlSaJnMHRIXTIUkSo9Sh7srRZ4Dys8NLJJbNVtk1UCYi0ZD5Vt
X-Received: by 10.224.16.135 with SMTP id o7mr57364599qaa.37.1415755569958;
	Tue, 11 Nov 2014 17:26:09 -0800 (PST)
Received: from localhost (c-73-38-182-46.hsd1.ma.comcast.net. [73.38.182.46])
	by mx.google.com with ESMTPSA id
	l67sm9609598qgd.49.2014.11.11.17.26.08 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 11 Nov 2014 17:26:08 -0800 (PST)
From: Cody P Schafer <dev@codyps.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 11 Nov 2014 20:25:59 -0500
Message-Id: <1415755559-4526-1-git-send-email-dev@codyps.com>
X-Mailer: git-send-email 2.1.3
X-Mailman-Approved-At: Sun, 23 Nov 2014 21:58:57 +0000
Cc: Cody P Schafer <dev@codyps.com>
Subject: [PATCH] Add readme noting location of mailing list
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
X-List-Received-Date: Wed, 12 Nov 2014 01:26:13 -0000

---
 README | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 README

diff --git a/README b/README
new file mode 100644
index 0000000..c434a1d
--- /dev/null
+++ b/README
@@ -0,0 +1,5 @@
+Mailing list:
+
+   bitbake-devel@lists.openembedded.org
+
+   http://www.openembedded.org/wiki/Mailing_lists
-- 
2.1.3


