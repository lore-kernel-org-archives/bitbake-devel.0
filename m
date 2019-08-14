Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
	[209.85.221.46])
	by mail.openembedded.org (Postfix) with ESMTP id 135CA7ECA6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Aug 2019 13:53:26 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id c3so2921899wrd.7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Aug 2019 06:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=DFifN8zGFbs1VfGzHEab4h1DYyTm0920HMn94SGFwis=;
	b=ZiuabF1OCy9d7+v667iIznBfmK8TGEj4/6g0a5pDU7spswNd4cnPspLfZrGtwsD46I
	eqlqwA1mfdatvsl8wgGRC3IH3s4ZjJAT90xjnNgGWJcaVErDEVObklA0Y1P1AALJd987
	9SkJ6zFesWDfCEo38xLhSEc3wjSX5jnDwGcW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=DFifN8zGFbs1VfGzHEab4h1DYyTm0920HMn94SGFwis=;
	b=V459IJ4uv/TJ9itoEudrycBUjQcNNWq5bSEagkhrBuMxg9nmRAXlUhDVWl/mPYkT25
	RpnMLsmLiV5mqMIixUNdftMkzalzo5uXEwDu+arvrkCfYDXx3oB8G7+lJWFVXEh5P8+2
	Xy7RGAkvDVN1z66dfqlML3vMCw6EAo/u1w6dynG+wum9LjXm58iALuQ0z0ncdGutsWLX
	TSL///QzpUe2KOkncoBpdHWKkyshRlU8fmsrNcrTM9XRXjrGoPXvlqUTpZ1IQnjB6RtI
	JfZ1R51x1c8yTtfeCsgNTordhAe5khfbaTc5JW+2hJTtRDB1Q/n+htVGBCG8JUo99w6t
	syMQ==
X-Gm-Message-State: APjAAAXaZ71hdXBpgGREeHpNrBgJOw/Gx15BpYTR4XhZGDsLcOEwuYDK
	lbgWF2T3XRiybTzXo1KMgNmWZEupa1oRhg==
X-Google-Smtp-Source: APXvYqyp8ODZDT6od7fumglpUGcdiKpT25KR0c+s1vGFm6TeVLwKRyTGQSCfAmb9gczltC23J0YS/g==
X-Received: by 2002:a5d:6911:: with SMTP id t17mr17169140wru.255.1565790807440;
	Wed, 14 Aug 2019 06:53:27 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	e6sm1859275wrr.14.2019.08.14.06.53.26
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 14 Aug 2019 06:53:26 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Aug 2019 14:53:17 +0100
Message-Id: <20190814135317.28887-10-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814135317.28887-1-richard.purdie@linuxfoundation.org>
References: <20190814135317.28887-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 10/10] runqueue: Drop debug statement causing performance issues
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
X-List-Received-Date: Wed, 14 Aug 2019 13:53:27 -0000
Content-Transfer-Encoding: 8bit

This debug statement could result in a long list of tasks which when
repeatedly sent over our IPC, slowed down the builds immensely. Remove
it in favour of other more targetted debugging added recently, brining
back some lost performance, partciclarly on builds with large numbers
of tasks.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index a04703c870..b571dde4bf 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2189,8 +2189,6 @@ class RunQueueExecute:
             for dep in self.sqdata.sq_covered_tasks[tid]:
                 if dep not in self.runq_complete:
                     self.holdoff_tasks.add(dep)
-        logger.debug(2, "Holding off tasks %s" % pprint.pformat(self.holdoff_tasks))
-
 
     def process_possible_migrations(self):
 
-- 
2.20.1


