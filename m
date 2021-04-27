Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
 by mx.groups.io with SMTP id smtpd.web10.4965.1619507196822459295
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Apr 2021 00:06:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=kDlxTsiY;
 spf=pass (domain: gmail.com, ip: 209.85.167.43, mailfrom: pgorszkowski@gmail.com)
Received: by mail-lf1-f43.google.com with SMTP id z13so11122815lft.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Apr 2021 00:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=xanKd+LhQslWkHcqKAi/01bInoNkWO7aRd0ccBNoRRA=;
        b=kDlxTsiYWhZPNF9D2zAH3bzXyVbYhjTOc/Phz/t+nxK/Og4ijtulOZgfSwtk/B6aNR
         i7W/UWU3ONXCXC4OFrmydhcQGMbu0RWz5c8OCMdeFjf8MMg6j8Dv3h14Roqb2SH3gf3f
         astmZ51tNrasRaC9TVhLauPo6YsBE4May7QcDYvnXFFIz8k2/qhv4v1YlLCeQ6UDWEpv
         GSQEj7C2BfwjM5Wn0E++NqgByzrPSt+Kz3nvMQwScrXYN57xjyyWj9Z44FQxn//ORDcR
         L5R0XU8Z6qA+CivHBWk8v8cZ/QgPRCK2Y2e1E9k7fxkEVAHC4K22IRdqp+QYmnuxi9jl
         R67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xanKd+LhQslWkHcqKAi/01bInoNkWO7aRd0ccBNoRRA=;
        b=TLPGBrqg1hAd+xBqaKXSljHKhQlNyEkbJa1m7huG7P0D9KDGPGSTEUxYgs4UEZcdfT
         JuQV4RZ0dtiEvPuLcKkDbBC2VfXzp9QpwzSwKwmGYALu12IFdk7ZopBEdpzhYdrS+q3n
         jOVs4kVR73h3kfEcKFgvGaAQ8hTUGo4iJY+A9bF6XvfYgdzfE7HvbmMSxDI4Zf1U7TwA
         BS6YsrMvXtRtkYKttj72lFyJiL04cMkxg3OVLdI+nRlhooRH4CAtBgcmMR3NZK4AKUPI
         5cpkX5ocB5xuySgWIxP9ac0rh1dDgx0vhD8oSSlBInVltbJBJtJTDf7or1XUq3z8mZE2
         FhTQ==
X-Gm-Message-State: AOAM533Y99/y8PLtYS0cQ6ijTtBwCrmK3xWlNcIpuxm9retDdtEVLQlZ
	TTq58Arq2fR8LE7hHy6bSRAFTS1UFO+qMcUpQg5j9BWlwNHYwA==
X-Google-Smtp-Source: ABdhPJyb4Uf5Bylx18gH1wvMLef5GFex9qRHEr/ccHcO8dXc36lUZbWKYhcKXLV86SC7os50StY/TYUlIJQFWhRgUpc=
X-Received: by 2002:a19:8c09:: with SMTP id o9mr10396254lfd.560.1619507194979;
 Tue, 27 Apr 2021 00:06:34 -0700 (PDT)
MIME-Version: 1.0
From: "Przemyslaw Gorszkowski" <pgorszkowski@gmail.com>
Date: Tue, 27 Apr 2021 09:06:24 +0200
Message-ID: <CAExyXVT_tcoWBihaTyfcmTEVfDxX1_34Q-p=+2wcO4JXZ+FtBA@mail.gmail.com>
Subject: [PATCH] LineFilterProgressHandler: fix parsing line which ends with CR only
To: bitbake-devel@lists.openembedded.org
X-Groupsio-MsgNum: 12267
Content-Type: multipart/mixed; boundary="000000000000117a2805c0eee757"

--000000000000117a2805c0eee757
Content-Type: multipart/alternative; boundary="000000000000117a2605c0eee755"

--000000000000117a2605c0eee755
Content-Type: text/plain; charset="UTF-8"

In case of some fetchers (like S3) the logs lines end with '\r' instead of
the expected '\n'. This patch fixes that case.

-- 
Best regards/Pozdrawiam

Przemyslaw Gorszkowski

--000000000000117a2605c0eee755
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">In case of some fetchers (like S3) the logs lines end with=
 &#39;\r&#39; instead of the expected &#39;\n&#39;. This patch fixes that c=
ase. <br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"gmail_signature=
" data-smartmail=3D"gmail_signature">Best regards/Pozdrawiam<br><br>Przemys=
law Gorszkowski</div></div>

--000000000000117a2605c0eee755--

--000000000000117a2805c0eee757
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-LineFilterProgressHandler-fix-parsing-line-which-end.patch"
Content-Disposition: attachment; 
	filename="0001-LineFilterProgressHandler-fix-parsing-line-which-end.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_knzor6zz0>
X-Attachment-Id: f_knzor6zz0

RnJvbSA2MzVlOWY1ZWI4MjRjNzNlN2M4MDQ1Yjk0NjIzNTIzMjhjNWJkNmQ1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQcnplbXlzbGF3IEdvcnN6a293c2tpIDxwcnplbWVrLmdvcnN6
a293c2tpQHJlZGVtYmVkZGVkLmNvbT4KRGF0ZTogTW9uLCAyNiBBcHIgMjAyMSAwOTozMjozNyAr
MDIwMApTdWJqZWN0OiBbUEFUQ0hdIExpbmVGaWx0ZXJQcm9ncmVzc0hhbmRsZXI6IGZpeCBwYXJz
aW5nIGxpbmUgd2hpY2ggZW5kcyB3aXRoCiBDUiBvbmx5CgotLS0KIGxpYi9iYi9wcm9ncmVzcy5w
eSB8IDcgKysrKystLQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9saWIvYmIvcHJvZ3Jlc3MucHkgYi9saWIvYmIvcHJvZ3Jlc3Mu
cHkKaW5kZXggZDA1MWJhMDEuLjUyZDcwNGQ2IDEwMDY0NAotLS0gYS9saWIvYmIvcHJvZ3Jlc3Mu
cHkKKysrIGIvbGliL2JiL3Byb2dyZXNzLnB5CkBAIC05NCwxMiArOTQsMTUgQEAgY2xhc3MgTGlu
ZUZpbHRlclByb2dyZXNzSGFuZGxlcihQcm9ncmVzc0hhbmRsZXIpOgogICAgICAgICB3aGlsZSBU
cnVlOgogICAgICAgICAgICAgYnJlYWtwb3MgPSBzZWxmLl9saW5lYnVmZmVyLmZpbmQoJ1xuJykg
KyAxCiAgICAgICAgICAgICBpZiBicmVha3BvcyA9PSAwOgotICAgICAgICAgICAgICAgIGJyZWFr
CisgICAgICAgICAgICAgICAgIyBmb3IgdGhlIGNhc2Ugd2hlbiB0aGUgbGluZSB3aXRoIHByb2dy
ZXNzIGVuZHMgd2l0aCBvbmx5ICdccicKKyAgICAgICAgICAgICAgICBicmVha3BvcyA9IHNlbGYu
X2xpbmVidWZmZXIuZmluZCgnXHInKSArIDEKKyAgICAgICAgICAgICAgICBpZiBicmVha3BvcyA9
PSAwOgorICAgICAgICAgICAgICAgICAgICBicmVhawogICAgICAgICAgICAgbGluZSA9IHNlbGYu
X2xpbmVidWZmZXJbOmJyZWFrcG9zXQogICAgICAgICAgICAgc2VsZi5fbGluZWJ1ZmZlciA9IHNl
bGYuX2xpbmVidWZmZXJbYnJlYWtwb3M6XQogICAgICAgICAgICAgIyBEcm9wIGFueSBsaW5lIGZl
ZWRzIGFuZCBhbnl0aGluZyB0aGF0IHByZWNlZGVzIHRoZW0KICAgICAgICAgICAgIGxicmVha3Bv
cyA9IGxpbmUucmZpbmQoJ1xyJykgKyAxCi0gICAgICAgICAgICBpZiBsYnJlYWtwb3M6CisgICAg
ICAgICAgICBpZiBsYnJlYWtwb3MgYW5kIGxicmVha3BvcyAhPSBicmVha3BvczoKICAgICAgICAg
ICAgICAgICBsaW5lID0gbGluZVtsYnJlYWtwb3M6XQogICAgICAgICAgICAgaWYgc2VsZi53cml0
ZWxpbmUoZmlsdGVyX2NvbG9yKGxpbmUpKToKICAgICAgICAgICAgICAgICBzdXBlcigpLndyaXRl
KGxpbmUpCi0tIAoyLjMxLjEKCg==

--000000000000117a2805c0eee757--
