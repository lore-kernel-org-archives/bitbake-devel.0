Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12795.1794580830805373702
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 13 Nov 2026 06:40:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=SswFgHGr;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: michalwsieron@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a215e64962so18381465e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 13 Nov 2026 06:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794580829; x=1795185629; darn=lists.openembedded.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KXIfh1QzjrhxglWm5VYll7ubt4I7l5YQyCdqiBe+DR0=;
        b=SswFgHGrt2ESvGsYUcFC+82Qd2d+z940yCz9Q2DgyCMDRibxESK5BMfyw4BI2b4JjK
         gvmAolYDyHerkN0fe0Qw6gxOxdAtQvbctmygjgScCEFiVf5ts/H0eKdh5bpHLErKpAhX
         aYMVLoENMWfscGN5QiHnCWqGw6uomf1svZwYT8t0mmtxglHAW0T6rjuVRj/Vv8Z/gNBI
         NPHJLYmDbS9GuIjAkRN9OabsfqXCVl8JvywDS82zJR5x518GI6e0B9GuhVwNfRteIMPj
         afL1CGVR0Cm3AF7bolmsyeZ2T1OYozMKqqhFMPuAoTD5UYDE1glGIds9T/QCEqddsS2f
         rP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794580829; x=1795185629;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KXIfh1QzjrhxglWm5VYll7ubt4I7l5YQyCdqiBe+DR0=;
        b=wdzRwWI93dPfRJeBaPDw+5sRkjRc5MLOnSMdI/0nKiaBwHwJ+vSI8ClzwIe1Jlo1Zi
         62ZDSkaTCuL33PEofAG45JpHs+4Ua6Xwc+xMzExT5k9xG0kKa7yZ0Ks39JDlaRvjLTuG
         pxnXUZpZvMlYWd4okWlT1V8mQLdWjyAbsEUxUGoPCTilUMaUj/mInfxAOQNoLGNkTzX5
         DN8ug8rlgXD5POi/3pBcw8Ud7tqTCBEk50A47zCaXAVoaHLzT7SeJQ+ZriicokXCGgj6
         KP6KrWigapYkUUFfR8ZT9mEb+aRNLi6HiflrW7UpL3An/RZ+MXEbdj2I3x0DutQu51sJ
         Wdqg==
X-Gm-Message-State: APuU4Z/hP3icGJ7YXuPrXqEXhRWZ7xA1VX+nenRXAwLpa96qIbGjenJM
	bDO7YoKPOdyfwH+gp+a2ibmJNNpMVN9TrBaR7BN9cEMu6EsDl3vBFZMEDlKYkchb
X-Gm-Gg: AYBFou0fSBGTIWqKXmm2IK3D74k5tbQ9MFxttkA+IYdI2U6XVm/kkWfCXpenl1z/9it
	OWBT4l/EoyB0jA04JotpxCnO6tK6SKyRWePgeog8HVyoDur1rYUrfBgbaEM1mgHyX9sEw3LBZi/
	LgylZcTLKuq71B0zV+nQqUsbNLDWy2O7JJqjzOFajmDxh4HKNJRHnZLVhpJrsMLmKQWQzUaYwAk
	kHxuwBYKtHQPQfrOvTF+6rU/rUGF2UMjiYBwGg4eSIGjM/AlqXJXK0GMakgKpwhb9ROXXJTHMtS
	ROY58TKrXflW6mVtbEdc5ThYNMD14/Cw7OawjD6vTsi8PNQ2XwaAbGAjBmvFkrLX1Hy3UcMyw/p
	Tlf7rjKqlX6cq1g/9TzJwSTBXs2OBJTOSkHG04CiSWqtBU+9AyZqIrsGqeJ6OejzBdePttNwOjN
	pK43hgHgagWMoodKmPoVDKegTApDNozpSmll0ekSWRDYPXx7Zn/nQwdYA9WMeQ2dXVEwnLaYFYC
	tqXFGKTi9f7tN9S+V3zoYJR53XhlXMBHMVUtykIsjLfIc7rcyrDaRmTqzWXOyGuZ9vI2ndMX80N
	6JP04xBXCs+8sgDh+rfjCMAiYQhEjutPcA==
X-Received: by 2002:a05:6000:4b06:b0:48d:ff06:c626 with SMTP id ffacd0b85a97d-49c71f33588mr5808799f8f.35.1794580828681;
        Fri, 13 Nov 2026 06:40:28 -0800 (PST)
Return-Path: <michalwsieron@gmail.com>
Received: from [127.0.1.1] ([193.28.84.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f1c193fsm5951028f8f.13.2026.11.13.06.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 06:40:28 -0800 (PST)
From: Michal Sieron <michalwsieron@gmail.com>
X-Google-Original-From: Michal Sieron <michal.sieron@nokia.com>
Date: Fri, 13 Nov 2026 15:40:24 +0100
Subject: [PATCH] data: Return frozenset from vardepvalueexclude
 dependencies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-msieron-snone-fix-v1-1-cb901b3a7396@nokia.com>
X-B4-Tracking: v=1; b=H4sIAFch92oC/yXMUQrCQAyE4auUPBvYtFKoVxEfbDraFMzKRkUov
 burPn4D868UKIagQ7NSwcvCslfIriGdz34F21RNbWp7Een4FoaSncOzgy/2ZtFhD+3SqGmi+rs
 X1PnXPJ7+jue4QB/fEG3bB/TiK0J1AAAA
X-Change-ID: 20261113-msieron-snone-fix-1c94ec30bc0d
To: bitbake-devel@lists.openembedded.org
Cc: Michal Sieron <michal.sieron@nokia.com>
X-Mailer: b4 0.15.2
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Fri, 13 Nov 2026 14:40:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20431

19475627c363a52da49ec144422c87448ff2a6c5 missed this one return point
when converting deps to a frozenset, which results in KeyError when
using `-Snone`.

Signed-off-by: Michal Sieron <michal.sieron@nokia.com>
---
 lib/bb/data.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index f81f44eac..f7bdc3272 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -308,7 +308,7 @@ def build_dependencies(key, keys, mod_funcs, shelldeps, varflagsexcl, ignored_va
         if key[-1] == ']':
             vf = key[:-1].split('[')
             if vf[1] == "vardepvalueexclude":
-                return deps, ""
+                return frozenset(deps), ""
             value, parser = d.getVarFlag(vf[0], vf[1], False, retparser=True)
             deps |= parser.references
             deps = deps | (keys & parser.execs)

---
base-commit: f22df7e0e00be1f3c406138b8b7269d47ea491fe
change-id: 20261113-msieron-snone-fix-1c94ec30bc0d

Best regards,
--  
Michal Sieron <michal.sieron@nokia.com>

