Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
 by mx.groups.io with SMTP id smtpd.web08.9003.1629857780095178571
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 Aug 2021 19:16:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=DfO5LSva;
 spf=pass (domain: gmail.com, ip: 209.85.219.171, mailfrom: mayank77fromindia@gmail.com)
Received: by mail-yb1-f171.google.com with SMTP id x140so10585161ybe.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 24 Aug 2021 19:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=YS8LuncWDk2qGYXeSOWFob82smox6hXp0j1Eg1+UMo0=;
        b=DfO5LSvakBd7YTwx7GyCunrIMIbdqbOEvwlT5jSFl8FrCI6UCf0w60qGzy/cZELgx2
         4XNKUUdMQE+I9gPYKcHEKxMtq5RklndrnPep/Z9OtGTjMLS2jY3mi5mEbaesip/QThmr
         EKB7QrzcL5MsMdJO/dhaTHx0lGH5Df8ct/PxrNLysle/93/bWcH7q6VyGxuHxTUrCdtw
         XtTuxBWWMlZzkbrUg6pQpuBdx5jCw4dpLfigW6bxZ1xOCDq31Tb3huhAcFR2z526V+wF
         2HvysrFxN6T902PdF0Qk+xS4g5nRPDi60PBaIBPI6znlMqEGznLein04oQ1AsKZA/GJB
         2mZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=YS8LuncWDk2qGYXeSOWFob82smox6hXp0j1Eg1+UMo0=;
        b=p0rDaFuc76MnoU3YyxgTxVJl+JCoLgyGKvhXjmX/ltkdQ3Jpg++3ZvMiq6pWf+VINk
         MHk3Q2eBUwXYDgOmnm+0tJ1/fmcJHh6wzxVEuLpa/ZiexzZt+ihSD2u65k0+Zw6kEhXx
         AbqeuTkMlEfIYcaHaGt3Wrj01OaOWf6gJ96L9O3u6A+/wQdNkgV+E/qCf0HXE8PwgTvu
         tIxsmIxuqxxUftDSSvqWCGCd9vMslsFf93ecctswaWg+K+SgxNsyXHzWmEW3xznUjx+v
         isoU2Dsg+hXRf7XKJvwdg0tkeQxi3vNPYRtfQP78taWl/N1RxXM4WN3L/Iep4Dguw/rx
         39cA==
X-Gm-Message-State: AOAM533xWzNXM7co9i9FngPR6CGV/eSqkZllCutUidttn0DTlJivp0Wx
	0JECFK/r0xrkg2KtTMt2q7FPsfPoupjXUTut+SAiU6yNbts=
X-Google-Smtp-Source: ABdhPJz9iOmA3IlV39FTFDoUKRYaMMNsc/uAXz1RtV7JMApE7CXQT/EU1RrqjnhZVitFaMYeMbnEB8c7dXFbfXBBhUw=
X-Received: by 2002:a25:ddc6:: with SMTP id u189mr53848367ybg.125.1629857779104;
 Tue, 24 Aug 2021 19:16:19 -0700 (PDT)
MIME-Version: 1.0
From: "Mayank Agarwal" <mayank77fromindia@gmail.com>
Date: Wed, 25 Aug 2021 07:46:06 +0530
Message-ID: <CAKjpqy+MdQPj58r5C9OYKRKLRUwmxG80+WK7YmrEsyKJYtx7=w@mail.gmail.com>
Subject: Cross compiling external package using yocto
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000f53eef05ca58d5e0"

--000000000000f53eef05ca58d5e0
Content-Type: text/plain; charset="UTF-8"

Hi,

How can i give the sysroot path oe_runmake using machine configuration in
yocto

Also to integrate external packages in yocto framework when we should write
configure.ac

Regards,
Mayank

--000000000000f53eef05ca58d5e0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div>Hi,</div><div><br></div><div>How can i give the s=
ysroot path oe_runmake using machine configuration in yocto</div><div><br><=
/div><div>Also to integrate external packages in yocto framework when we sh=
ould write <a href=3D"http://configure.ac">configure.ac</a></div><div><br><=
/div><div>Regards,</div><div>Mayank</div></div>

--000000000000f53eef05ca58d5e0--
