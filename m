Return-Path: <isaac.true@emlix.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD80C54FB3
	for <webhook@archiver.kernel.org>; Mon, 26 May 2025 14:06:42 +0000 (UTC)
Subject: Re: [PATCH] fetch2: add support for .debs containing uncompressed data tarballs
To: bitbake-devel@lists.openembedded.org
From: "Isaac True" <isaac.true@emlix.com>
X-Originating-Location: Griesheim, Hesse, DE (80.152.190.82)
X-Originating-Platform: Linux Firefox 138
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 26 May 2025 07:06:41 -0700
References: <20250526135733.1082741-2-isaac.true@emlix.com>
In-Reply-To: <20250526135733.1082741-2-isaac.true@emlix.com>
Message-ID: <15379.1748268401915163843@lists.openembedded.org>
Content-Type: multipart/mixed; boundary="Qjbr6CZA2ccjGyyZgQjN"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 26 May 2025 14:06:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17642

--Qjbr6CZA2ccjGyyZgQjN
Content-Type: multipart/alternative; boundary="17eSOeD3sjFiUJ4oK9Hp"

--17eSOeD3sjFiUJ4oK9Hp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I think git-send-email did something strange with the text encoding here so=
 I've attached the .patch here additionally as a file.

--17eSOeD3sjFiUJ4oK9Hp
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>I think git-send-email did something strange with the text encoding he=
re so I've attached the .patch here additionally as a file. </div>

--17eSOeD3sjFiUJ4oK9Hp--

--Qjbr6CZA2ccjGyyZgQjN
Content-Type: text/x-patch; name="0001-fetch2-add-support-for-.debs-containing-uncompressed.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-fetch2-add-support-for-.debs-containing-uncompressed.patch"

RnJvbSA1YjQ5YjcxNTkxZDVhMDYyZWViNDEwMTBjYTFhNDhiMjI1YmZjYmMxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBJc2FhYyBUcnVlIDxpc2FhYy50cnVlQGVtbGl4LmNvbT4KRGF0
ZTogTW9uLCAyNiBNYXkgMjAyNSAxMzoxODoyNiArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIGZldGNo
MjogYWRkIHN1cHBvcnQgZm9yIC5kZWJzIGNvbnRhaW5pbmcgdW5jb21wcmVzc2VkIGRhdGEKIHRh
cmJhbGxzCgpTb21lIC5kZWIgZmlsZXMgY29udGFpbiB1bmNvbXByZXNzZWQgZGF0YSB0YXJiYWxs
cyB3aGljaCBkbyBub3QgaGF2ZSBhbgphZGRpdGlvbmFsIGZpbGUgZXh0ZW5zaW9uIGFmdGVyIGAu
dGFyYC4gQWRkIHN1cHBvcnQgZm9yIHN1Y2ggY2FzZXMgd2hpbGUKcHJlc2VydmluZyB0aGUgZXhp
c3RpbmcgYmVoYXZpb3VyLgoKU2lnbmVkLW9mZi1ieTogSXNhYWMgVHJ1ZSA8aXNhYWMudHJ1ZUBl
bWxpeC5jb20+Ci0tLQogbGliL2JiL2ZldGNoMi9fX2luaXRfXy5weSB8IDQgKystLQogMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9s
aWIvYmIvZmV0Y2gyL19faW5pdF9fLnB5IGIvbGliL2JiL2ZldGNoMi9fX2luaXRfXy5weQppbmRl
eCA4ZjBlZDJiOWUuLjA2Mzc4ZTk2ZCAxMDA2NDQKLS0tIGEvbGliL2JiL2ZldGNoMi9fX2luaXRf
Xy5weQorKysgYi9saWIvYmIvZmV0Y2gyL19faW5pdF9fLnB5CkBAIC0xNTY5LDExICsxNTY5LDEx
IEBAIGNsYXNzIEZldGNoTWV0aG9kKG9iamVjdCk6CiAgICAgICAgICAgICAgICAgZGF0YWZpbGUg
PSBOb25lCiAgICAgICAgICAgICAgICAgaWYgb3V0cHV0OgogICAgICAgICAgICAgICAgICAgICBm
b3IgbGluZSBpbiBvdXRwdXQuZGVjb2RlKCkuc3BsaXRsaW5lcygpOgotICAgICAgICAgICAgICAg
ICAgICAgICAgaWYgbGluZS5zdGFydHN3aXRoKCdkYXRhLnRhci4nKToKKyAgICAgICAgICAgICAg
ICAgICAgICAgIGlmIGxpbmUuc3RhcnRzd2l0aCgnZGF0YS50YXIuJykgb3IgbGluZSA9PSAnZGF0
YS50YXInOgogICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRhdGFmaWxlID0gbGluZQogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrCiAgICAgICAgICAgICAgICAgICAgIGVsc2U6
Ci0gICAgICAgICAgICAgICAgICAgICAgICByYWlzZSBVbnBhY2tFcnJvcigiVW5hYmxlIHRvIHVu
cGFjayBkZWIvaXBrIHBhY2thZ2UgLSBkb2VzIG5vdCBjb250YWluIGRhdGEudGFyLiogZmlsZSIs
IHVybGRhdGEudXJsKQorICAgICAgICAgICAgICAgICAgICAgICAgcmFpc2UgVW5wYWNrRXJyb3Io
IlVuYWJsZSB0byB1bnBhY2sgZGViL2lwayBwYWNrYWdlIC0gZG9lcyBub3QgY29udGFpbiBkYXRh
LnRhciogZmlsZSIsIHVybGRhdGEudXJsKQogICAgICAgICAgICAgICAgIGVsc2U6CiAgICAgICAg
ICAgICAgICAgICAgIHJhaXNlIFVucGFja0Vycm9yKCJVbmFibGUgdG8gdW5wYWNrIGRlYi9pcGsg
cGFja2FnZSAtIGNvdWxkIG5vdCBsaXN0IGNvbnRlbnRzIiwgdXJsZGF0YS51cmwpCiAgICAgICAg
ICAgICAgICAgY21kID0gJ2FyIHggJXMgJXMgJiYgJXMgLXAgLWYgJXMgJiYgcm0gJXMnICUgKGZp
bGUsIGRhdGFmaWxlLCB0YXJfY21kLCBkYXRhZmlsZSwgZGF0YWZpbGUpCi0tIAoyLjM5LjUKCg==

--Qjbr6CZA2ccjGyyZgQjN--

