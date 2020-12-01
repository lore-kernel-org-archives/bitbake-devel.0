Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
 by mx.groups.io with SMTP id smtpd.web09.12639.1606840024216025580
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Dec 2020 08:27:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=D17ljZfb;
 spf=pass (domain: gmail.com, ip: 209.85.167.44, mailfrom: ernstp@gmail.com)
Received: by mail-lf1-f44.google.com with SMTP id q13so5327855lfr.10
        for <bitbake-devel@lists.openembedded.org>; Tue, 01 Dec 2020 08:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x0BzUu3gh5s3YfjCvXlWhVQOW4yV6EKgtd9dEfs/gJo=;
        b=D17ljZfbqHpLV/ioe2Kb7g8n3wEMocLOfqd/BxNGRNyegLDxMwrpVB1ihGoxmRYHSG
         xGRoE3w6l9N44nF4mhTEmf+hnlFEit8FnW/pVHBirQhkc2YHHGAfsEGdDYAIyKJDNopP
         npVn0tMb2crihmaSfJHOT2yHBGurO6UaogBIlDte8noBAcmCRxgsNKb8e4+/I7RNtsQm
         cWMglw+AwtAXXsL9+kXgVGHVTBLZxq9EAQ7KEvf3bRjOB2YHz02f5A9rV17aAVE149I4
         M4WRGD/pevbdAGhGEuDamc/vpC9rUY9brnheXUAjx2VkS6QY+BxO3ScKR9paQ36hBBug
         TXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x0BzUu3gh5s3YfjCvXlWhVQOW4yV6EKgtd9dEfs/gJo=;
        b=D4mQ7G8+0Pt/d6dHOatk/CgNK13CnG5J1+5bRwyM8FIpgT+MKFmaS5T9eEPqh+DXhx
         mPm7BSKDbO2oSMYbCXLbLZHqs5Q9wqOJQ0dY0sA/NPOO8vxNQ/Xp9NGbT636A0rtIPeS
         uko33nFQo+DrVAGNv39Ba4LhQH54jM7OaMEZi1rKrBpRXh5b57h9RZmeYzirx4hrhRpd
         G8fRwmV8lZOjf9+U3Y6JxyXUiS6P2k3uWoC5h8zxpOjwby9S+0xIdUAJAUwrd24ng1cK
         IV2ajgL5AYAAPWSsn/us0XMHgbZog2B3Kv9jUlxJA+LrTbGo5vR+4BesI3GRBkGKXVAY
         0HqA==
X-Gm-Message-State: AOAM533sNicSlKDzvACKDDz4jFliEx8FeO7Qh2DdbPjT04AmijW1+A7s
	Ge1XUEQ3Q63ODtFsWXwH5IFesTWpDF4=
X-Google-Smtp-Source: ABdhPJz81CifPMpSME76tzoWXIaPOrXlHifocOa5AnkJc4Q3LePZr5GvbJixta/RMlRqpDVmxsYpGQ==
X-Received: by 2002:a19:42c3:: with SMTP id p186mr1486907lfa.218.1606840022384;
        Tue, 01 Dec 2020 08:27:02 -0800 (PST)
Return-Path: <ernstp@gmail.com>
Received: from localhost.localdomain (c83-254-138-119.bredband.comhem.se. [83.254.138.119])
        by smtp.gmail.com with ESMTPSA id j131sm248746lfd.209.2020.12.01.08.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 08:27:01 -0800 (PST)
From: =?UTF-8?B?RXJuc3QgU2rDtnN0cmFuZA==?= <ernstp@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [dunfell 3/5] distutils3-base.bbclass: use python3targetconfig
Date: Tue,  1 Dec 2020 17:26:25 +0100
Message-Id: <20201201162627.47760-3-ernstp@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201201162627.47760-1-ernstp@gmail.com>
References: <20201201162627.47760-1-ernstp@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Kanavin <alex.kanavin@gmail.com>

(From OE-Core rev: 9c8f666097802cb594a759989edcf01603a22df3)

Signed-off-by: Alexander Kanavin <alex.kanavin@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 3ec7f79ad2687381300010392c3320cca0dc638e)
---
 meta/classes/distutils3-base.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta/classes/distutils3-base.bbclass b/meta/classes/distutils3-base.bbclass
index 7dbf07ac4b..a277d1c7bc 100644
--- a/meta/classes/distutils3-base.bbclass
+++ b/meta/classes/distutils3-base.bbclass
@@ -1,5 +1,5 @@
 DEPENDS  += "${@["${PYTHON_PN}-native ${PYTHON_PN}", ""][(d.getVar('PACKAGES') == '')]}"
 RDEPENDS_${PN} += "${@['', '${PYTHON_PN}-core']['${CLASSOVERRIDE}' == 'class-target']}"
 
-inherit distutils-common-base python3native
+inherit distutils-common-base python3native python3targetconfig
 
-- 
2.29.2

