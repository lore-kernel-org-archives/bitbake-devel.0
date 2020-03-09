Return-Path: <jpewhacker@gmail.com>
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com
	[209.85.166.194])
	by mail.openembedded.org (Postfix) with ESMTP id D61E261B4D
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Mar 2020 16:34:08 +0000 (UTC)
Received: by mail-il1-f194.google.com with SMTP id f5so9249003ilq.5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Mar 2020 09:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Y1dLSlyWy/MiZgoP6iiF/6QwWYrXPTD2jEbFS7UdqNI=;
	b=JXFwS4h+eGadAyWcvsKwBus+kITTz4bXLWkQvazsqByJIwlFKGt0D4Kk+xXHvqPGXX
	brLaRoPUNtr+psSH8vvRbCHv+Wn3c17IehOyCBKdk+Rj64JueBzja3rSQ+pCackH9rmv
	OmA2x8WnaNJRxk4WtcY9kdpqvj5sNm9tXJb2d//fIdOTy/fW+a1LavylcnT4QtiMGjw+
	92YBUdFNOddTndLrPc80yF5MizLXZWbEdQ1XY5StUbCRdqNgbN0YsSv3pRHtLcnklKbA
	qJ6EZs0yQhkaZtaj0KP5x/vy2zGHTCGFOvGDmWQEdgou1uolA+Ji9RmUCVruxsMUWxC/
	NisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Y1dLSlyWy/MiZgoP6iiF/6QwWYrXPTD2jEbFS7UdqNI=;
	b=LSEMqBIGPau3DsqT5BmWFlSFebp7SEhhkbJ2o//xLGYxl9Y6hWtPbsBHeNI3UlGYZb
	AUVRHXsWbG39k48tTvKRH1xOdYzocAZbO2M3kFDThHZ8+gvql8yvvV/1tkjtAnWxdQmY
	GEfndEFy5LrdST/Aq+THjOkMI8vZzE2jF/f6UazM5/bmU+XlUXA8GuIN4TGdXY7wtIxY
	eOSjbkLbNQTaZaafRkzASpT26f6fOKbTbPva6EznPU0bSOcg++6qetoGA7wl1BS7Wi+0
	cqXchGaecBGxOdDIXQp4W4tIdHAKDYBcsQUi1KKZYDG0OzPPYO3uExf5vCj7FHyDna1P
	CilQ==
X-Gm-Message-State: ANhLgQ3eQdg4Pv4Ozff46upKFoFZUpcpA1kGsyiWA5QoCybxrUt7schE
	sMlqkl0rWLFtjgvzCfjpN5eYLXbfAhg=
X-Google-Smtp-Source: ADFU+vvmbgqZCQhouxgczl8/m7BeMRJZq0T4nRdXTHTLWBUn4yZOIt1EsZJQV0jOogtTwdX/0XBM9Q==
X-Received: by 2002:a92:ce05:: with SMTP id b5mr16143000ilo.303.1583771649588; 
	Mon, 09 Mar 2020 09:34:09 -0700 (PDT)
Received: from OLA-8C37N23.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	q1sm15049593ile.71.2020.03.09.09.34.08
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 09 Mar 2020 09:34:09 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Mar 2020 11:33:49 -0500
Message-Id: <20200309163353.15362-12-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309163353.15362-1-JPEWhacker@gmail.com>
References: <20200309163353.15362-1-JPEWhacker@gmail.com>
Cc: docs@lists.yoctoproject.org
Subject: [PATCH 11/15] bitbake: worker: Remove unnecessary addDefaultLogFilter
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
X-List-Received-Date: Mon, 09 Mar 2020 16:34:09 -0000

Adding the default log filter here is unnecessary because there are no
defined logging domains when it is called, which means it does no actual
filtering.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/bin/bitbake-worker | 1 -
 1 file changed, 1 deletion(-)

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index fc28a34d8a..97cc0fd60f 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -65,7 +65,6 @@ if 0:
     format_str = "%(levelname)s: %(message)s"
     conlogformat = bb.msg.BBLogFormatter(format_str)
     consolelog = logging.FileHandler(logfilename)
-    bb.msg.addDefaultlogFilter(consolelog)
     consolelog.setFormatter(conlogformat)
     logger.addHandler(consolelog)
 
-- 
2.17.1


