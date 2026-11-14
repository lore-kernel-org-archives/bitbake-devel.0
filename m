Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2400.1794682542696592804
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 14 Nov 2026 10:55:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=WS+/2vL5;
 spf=pass (domain: gmail.com, ip: 209.85.216.47, mailfrom: bbnpreetsingh@gmail.com)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b09c07b3d2so1287189a91.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 14 Nov 2026 10:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794682542; x=1795287342; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=55xBxy1FmOrXNvaXHIAbEjfCE8xfzW72O9KhmQR/n24=;
        b=WS+/2vL5dimG0bq2pp4qogTX8Y0JRQsgdvKSmlvmTfnifJogvzvVlNUmYTjXuIaHm8
         9HxBXwOjrYDeLOaOIc+oUY4r2ZnHIApAtqjSACzn9bfJF/NyOeMuWuFJldVGKzlH2jj9
         vz6GBaEP/Se7vIUTLmKsI+vbsCOLZ2k6etJSc299iBJUMjG9+3JbnOy1AL1x7h8x2Ew/
         JEOrpDzfynpzJyFLSwIwkMqmH+iu9CzyX2qx+dpTrOncDzEqzKdATjjbteI3on/Hztxt
         Q26iHiycWHKF/pnVphjSkCESbNpu9DM3OnJ6j+exZ+zyTJFxE9PaQCc6nSHUajeg0eUF
         QLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794682542; x=1795287342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=55xBxy1FmOrXNvaXHIAbEjfCE8xfzW72O9KhmQR/n24=;
        b=xWCUPgoCDKf0mxpBGZdsGGzrSp8vfeD0OT83lx0/vMu3ej5I/phFO6a2cGL0f8tpIp
         5L2O/Zkb/hyBURS+t9KvZes9t4W9fzhRDzwJqywqgu81j36qHCbTNU3Wq6DlJML+vVNe
         6aOr2EPr/IOUmN0RRjLzoqoJBDY+mRNqpO2iESOUpRvLSjZETsuw0OvmvrHcZCIax0vR
         OPqhTKV6RflRBC5FeQYJ2x7ZdMyO1nHJBnMzUI9JLojhx4nf2h8Z5YHUiS6Qetq8kqFT
         ojOZxVnPkoQoCLfBODdJAKJe7YxlwR+vhjPa+L1gOzjJlTsgJ1QR7kybZVrF9vGfTflu
         wsWA==
X-Gm-Message-State: APuU4Z86M/5Icbqu/9XP3uXo8VwH/DaPrloNh+5hZ4NSKDRKhKaLZHcn
	Qr5fs8mjhgBJEhskFtKWT/lnybwJRD04xPLM4en109MaqxhmecXmOnzW
X-Gm-Gg: AYBFou3r4tfuP8BJ/h8ZfwK6dslYsVTy4pDqAitJJncPTuBM1Ml5AyOcTQBJ0SVwIA8
	wHqVUbYkMyOGEDpYGTSFWcIqE3OIjp33BsUYSRJ581v7cqbt9kVYUAY2BMGAH2fmzUqnjdNkrQI
	3Gyxn3wb43N2QSO8N6TEMMWNMJYZoKauMWBdZ+rS2WtbOc6bPNpTeaG162ok6bPtrFr1XMY6RXC
	GAQh1abAOwiuASekAim9hYb3JqS8MD+PHM+m6VQcjmfSTTBe7Mqzj5nekLBGqGxG7Al+WmIqLFN
	aKSy55Dqf7P0EBvBBrE4cvwb8vYy7oMbDtZU1lnYAEb/gLCITDheo5znnfGMWooPfBRg6/6kU+K
	TU2LVWtE8GAqRbItwxI0CVZVBKjFtYmIWtkiL/xdFgqVlqobWPVc4cX7zay9a3RDOnnFnYLfq1C
	qF5JxjoRWsMifos+YkAJGV9RMKvQrrXsgGtx5PQrYu2qnEAAhqwmUezXP8yfR8MoUfa6W4Gpjm6
	Lnm+gGcJR0OV+XO2EYyE4lcwL5MMooekKy2dGPLeS4Zs36UZV97c/SA9WjkvpxRG+R/EwytZTNE
	0OZzjATxFOABnao7Iz1UW11Zebj/lE/2g6Ruv6SV0INgEvpHKFow0oAPsmTrHaQ=
X-Received: by 2002:a17:90a:dfc6:b0:39e:6a7e:ee18 with SMTP id 98e67ed59e1d1-3b1b0b65a3cmr5760758a91.36.1794682542098;
        Sat, 14 Nov 2026 10:55:42 -0800 (PST)
Return-Path: <bbnpreetsingh@gmail.com>
Received: from localhost.localdomain ([108.180.159.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec3af2dsm9577581a91.9.2026.11.14.10.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 10:55:41 -0800 (PST)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: Re: [PATCH] cooker: create missing eventlog directory
Date: Sat, 14 Nov 2026 18:55:40 +0000
Message-ID: <20261114185540.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113-mathieu-b16492-write-variables-v1-1-9f1f86aebc8b@bootlin.com>
References: <20261113-mathieu-b16492-write-variables-v1-1-9f1f86aebc8b@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Sat, 14 Nov 2026 18:55:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20433
Content-Type: text/plain; charset="utf-8"

On Fri, 13 Nov 2026 at 15:34 +0100, Mathieu Dubois-Briand wrote:
> If the eventlog folder is removed while bitbake is still resident in
> memory, it will not be re-created on the next build and result in an
> exception while trying to write event logs. Catch this exception and
> create the folder as expected.
>
> [YOCTO #16492]
>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

The steps from the bug pass here with this applied.

Tested-by: Babanpreet Singh <bbnpreetsingh@gmail.com>

Baban
