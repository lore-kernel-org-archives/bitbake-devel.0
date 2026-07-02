Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278C8C43458
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 14:23:15 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.60708.1782959141722044998
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Jul 2026 19:25:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=TMeTERc8;
 spf=pass (domain: gmail.com, ip: 209.85.218.44, mailfrom: dchvs11@gmail.com)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c126eb4e003so115383666b.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Jul 2026 19:25:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782959140; cv=none;
        d=google.com; s=arc-20260327;
        b=eZNr54RS2/875+MkwU/SN7RCsxL9J6kEgj03KlWsbJTfNqfwyxf5OvseHo8f94EC98
         fG0R9hzeU1+TL/5x8TCn4kOhTVdzFUaiS/FzOAg0nhGHnbnZUfMgthQg6LUZqz4gYmsm
         S6wPgbgW9hnbaIIya8eolukH8zUzJs3cK/VgLsRpS6F3XB2kiLubw4nzv1oeSOSkRHw9
         VJKk+bHiFqFVbEqFRTce2knm4hlCWGLG5Adt9anIttL+KJdB4jdopPycLUe2D0cRWSO5
         /n0/KakQrvk6iHyjx6WZ55/0OTYrWV1v0ml3bot0cc/dhFFB5yQhkHA+n5lddkV7Z2st
         iicA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=+I5moibnu0Uek061+5qYhh/omIGkLha6tAeVf0VX8QM=;
        fh=ZYcwCaqfhSVL6aqQEereyJKILpVTA7dZeRdqvWG/C7s=;
        b=LNV5upe7+k8PeBJv0p1CUdXZaircThwU0mBmu62JFrqiSOEus2gnwhjIWclseMFX9z
         g/Zemfqt21P0VSZ5LtnQ6pDNow5OG3YO53SiZMoi1s7a6u+oGUQH2XagDMyW1sc2a3xz
         vMvkXR6soe+R7OKy+HVPweLnVqtkyUUJg79YLZqeHul7qdKewMwH4Uld+UgNGiZnS3r4
         jfPe/cbBACGsLbdBkO22FKgRghVCCuT8JDnjXpRBiXT+ow1yAwWDvF4sdX1UiXLbgXto
         L3DuC3YoQrfsvcfwCIUqjdZGCZWdXNrwz0syZq2eTXeIpfL/B28wGRvkXJIDJJOKmjJw
         Ajzg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782959140; x=1783563940; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+I5moibnu0Uek061+5qYhh/omIGkLha6tAeVf0VX8QM=;
        b=TMeTERc8s/5Ucu8RDlyQIo4IxsI0cgrb05VAIGwKwxuUjN43M5+/ltoJn7HHMuWQPW
         eUOnb2s7Kg0lek7lm4G3ASG5mFi+4tccNvmZOQnbKPHELgYKdHbbcLyefZYVh5pFFsFi
         PUIzVaL1m0WOAzJdCEY/Ic1OqwDNre5cv3xBLM+zLCrKzxs9Spvkb6AXTuSsr2r0Qw92
         nm6QWW5E5nRsrx0rsKKtwDMZw9/TGCC6E0sni0Kv5VG4VRDju9T8L1px+Vd1slAWS9P7
         e0twXnTHBWEs3QOR2PgObum5sYP3e6AJu8q3twxRNpN1WEi2u4Acat8pLDEqHPqQ9+WO
         DqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782959140; x=1783563940;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+I5moibnu0Uek061+5qYhh/omIGkLha6tAeVf0VX8QM=;
        b=MP91zyEHCftL7G07C1HFTZOkmaFL3NJNubrK4Fu+t1gzrsXmBKUxz7LfgXe7MZtYvQ
         NiTmCLUjU+vSOOxbud3HK/mef4rTBiVTjgG4pQUUwUaoarFRDwWhclDKNEr8W7fENh4I
         pHR/rcoo3YmoAchFpt+1JWH7JDooRuYO3c9I0mCSaIJKVJTA5awi1AVXHD36Qfp1ETG0
         +rtN15Q+ruHe49TIwA/DhLGK/r56Dx+ZCWEW7u5TNHzH5fpV7vK3ROerE8gDbMj1wc6t
         K+3qebZMXIltEwRFUSa5b2KrNgWdYcbajbcQ5EMg9cDmAURLKY9qlhIjcmZJZViYP8RZ
         s2DQ==
X-Gm-Message-State: AOJu0YxBgVgC//jd4yxeZBgFCUoW6vGuHYVjCD2PEIEQY2u34qm5Ayfj
	hxwWgJe4tzmztDNuiUHBHzNe3Fq84EeEGAfRsCOpEXcjy/h6FDpa24V9JUJKEo7EBBIQj/RJHqn
	/KD0ezy7BHQWIy1j6aYH/7veI3bJ7FwRBOhgR
X-Gm-Gg: AfdE7clT61EkTtbclaRmQilL47z1cKu0puHyoJjvVEF/cS3rOw8C2BYCDK8poe2RqRQ
	Xb/vgw6QSZtsO7YlFNOvN/uGd6xF7dIwbwsvYyl6VD95NjSFVmUkAOhdzvg3IWVbhXg6vcpJ2KY
	Zet1LuxaeWKban/741sRqEm2f/buZajPXGT8BuZJS/OtC0GxvMKwJEkAAwZOVWIloje2hPpT4kZ
	ucwnbGsmdv0/P7UaBD5XBFmuUJ7aVSy59FDGmFef81cgnZhblwauoqCDXs+z0BNeWlzkX+MOuuN
	+WuIIWRjDw==
X-Received: by 2002:a17:907:9694:b0:c12:a999:ab with SMTP id
 a640c23a62f3a-c12aa4aca96mr209785866b.63.1782959139906; Wed, 01 Jul 2026
 19:25:39 -0700 (PDT)
MIME-Version: 1.0
From: "Daniel" <dchvs11@gmail.com>
Date: Wed, 1 Jul 2026 20:25:28 -0600
X-Gm-Features: AVVi8CevvSPrb93dQ4Ht8TxyNF33qIt6zuQ_KzSjFgCe9x0QPXX5XrNADOfqUyU
Message-ID: <CANDCFSymKLKTANt3dti9YW+OncTfCQyArCjoSY=EzvBLyoi1WQ@mail.gmail.com>
Subject: [PATCH] bitbake-setup: support --update-bb-conf on init and fix site.conf symlink for setup-dir == top-dir #bitbake #yocto
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, alex.kanavin@gmail.com
Content-Type: multipart/mixed; boundary="0000000000002f272006559786aa"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Jul 2026 14:23:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19813

--0000000000002f272006559786aa
Content-Type: text/plain; charset="UTF-8"



--0000000000002f272006559786aa
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-bitbake-setup-support-update-bb-conf-on-init-and-fix.patch"
Content-Disposition: attachment; 
	filename="0001-bitbake-setup-support-update-bb-conf-on-init-and-fix.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mr2vo45r0>
X-Attachment-Id: f_mr2vo45r0

RnJvbSA0NzI4YzY5ZDY4MjQ1MWIxYjUwOTMwY2NiMzdkYWVkY2ZkMTJmZTgzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgQ2hhdmVzIDxkY2h2czExQGdtYWlsLmNvbT4KRGF0
ZTogV2VkLCAxIEp1bCAyMDI2IDIwOjAxOjQ2IC0wNjAwClN1YmplY3Q6IFtQQVRDSF0gYml0YmFr
ZS1zZXR1cDogc3VwcG9ydCAtLXVwZGF0ZS1iYi1jb25mIG9uIGluaXQgYW5kIGZpeAogc2l0ZS5j
b25mIGZvciBzZXR1cC1kaXIgPT0gdG9wLWRpcgoKVHdvIGZpeGVzIHRoYXQgd29yayB0b2dldGhl
ciB0byBsZXQgYGJpdGJha2Utc2V0dXAgaW5pdGAgcHJlc2VydmUgYW4KZXhpc3RpbmcgYml0YmFr
ZSBidWlsZCBjb25maWd1cmF0aW9uIChsb2NhbC5jb25mLCBiYmxheWVycy5jb25mKToKCjEuIEV4
cG9zZSB0aGUgZXhpc3RpbmcgYHVwZGF0ZV9iYl9jb25mYCBwYXJhbWV0ZXIgdGhyb3VnaCBhIG5l
dwogICBgLS11cGRhdGUtYmItY29uZmAgQ0xJIGZsYWcgb24gYGluaXRgLCBtYXRjaGluZyB0aGUg
c2VtYW50aWNzIG9mCiAgIGBiaXRiYWtlLXNldHVwIHVwZGF0ZWAuIFRoaXMgbGV0cyBkb3duc3Ry
ZWFtIHByb2plY3RzIHJlLXJ1biBpbml0CiAgIChlLmcuLCB0byByZWZyZXNoIGxheWVycyB2aWEg
LS1zb3VyY2Utb3ZlcnJpZGVzKSB3aXRob3V0IGxvc2luZwogICB0aGVpciB0cmFja2VkIGNvbmYg
ZmlsZXMuIERlZmF1bHQgcmVtYWlucyAieWVzIiBmb3IgYmFja3dhcmQKICAgY29tcGF0aWJpbGl0
eS4KCjIuIEZpeCB0aGUgc2l0ZS5jb25mIHN5bWxpbmsgdGFyZ2V0IHdoZW4gdGhlIHNldHVwIGRp
cmVjdG9yeSBpcyB0aGUKICAgc2FtZSBhcyB0aGUgdG9wIGRpcmVjdG9yeS4gVGhlIHN5bWxpbmsg
dGFyZ2V0IHdhcyBhbHdheXMgY29tcHV0ZWQKICAgYXMgYHNldHVwZGlyLy4uL3NpdGUuY29uZmAs
IHdoaWNoIG9ubHkgbWF0Y2hlcyB0aGUgYWN0dWFsIHNpdGUuY29uZgogICBsb2NhdGlvbiAodG9w
X2Rpci9zaXRlLmNvbmYpIHdoZW4gdGhlIHNldHVwIGRpcmVjdG9yeSBpcyBleGFjdGx5CiAgIG9u
ZSBsZXZlbCBiZWxvdyB0aGUgdG9wIGRpcmVjdG9yeS4gV2hlbiBgLS1zZXR1cC1kaXItbmFtZWAg
aXMgZ2l2ZW4KICAgYW4gYWJzb2x1dGUgcGF0aCBlcXVhbCB0byB0aGUgdG9wIGRpcmVjdG9yeSwg
dGhlIHN5bWxpbmsgZW5kcyB1cAogICBicm9rZW4sIHdoaWNoIGNhdXNlcyBgZGlmZiAtdU5yYCB0
byBmYWlsIHdpdGggZXhpdCBjb2RlIDIgaW5zaWRlCiAgIHNldHVwX2JpdGJha2VfYnVpbGQoKS4g
VGhhdCBleGNlcHRpb24gaXMgcmFpc2VkIGJlZm9yZSB0aGUKICAgYHVwZGF0ZV9iYl9jb25mID09
ICdubydgIGJyYW5jaCBjYW4gcmVzdG9yZSB0aGUgb3JpZ2luYWwgY29uZiwKICAgZGVmZWF0aW5n
IHRoZSBuZXcgZmxhZyBmcm9tICMxLgoKVG9nZXRoZXIsIHRoZXNlIGNoYW5nZXMgbWFrZSBgYml0
YmFrZS1zZXR1cCBpbml0IC0tdXBkYXRlLWJiLWNvbmY9bm9gCmJlaGF2ZSBsaWtlIFlvY3RvJ3Mg
YG9lLWluaXQtYnVpbGQtZW52YDogdGhlIGJ1aWxkIGVudmlyb25tZW50IGlzCnByZXNlcnZlZCBh
Y3Jvc3MgcmUtaW5pdGlhbGl6YXRpb25zLgoKU2lnbmVkLW9mZi1ieTogRGFuaWVsIENoYXZlcyA8
ZGNodnMxMUBnbWFpbC5jb20+Ci0tLQogYmluL2JpdGJha2Utc2V0dXAgfCA5ICsrKysrKystLQog
MSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9iaW4vYml0YmFrZS1zZXR1cCBiL2Jpbi9iaXRiYWtlLXNldHVwCmluZGV4IDk3ZWEwOGQx
MS4uOWE1OWE1YWFhIDEwMDc1NQotLS0gYS9iaW4vYml0YmFrZS1zZXR1cAorKysgYi9iaW4vYml0
YmFrZS1zZXR1cApAQCAtMzcxLDcgKzM3MSwxMCBAQCBkZWYgc2V0dXBfYml0YmFrZV9idWlsZChi
aXRiYWtlX2NvbmZpZywgbGF5ZXJkaXIsIHNldHVwZGlyLCB0aGlzZGlyLCB1cGRhdGVfYmJfYwog
ICAgIF9wcmVwZW5kX3Bhc3N0aHJvdWdoX3RvX2luaXRfYnVpbGRfZW52KGJpdGJha2VfYnVpbGRk
aXIpCiAKICAgICBzaXRlY29uZl9zeW1saW5rID0gb3MucGF0aC5qb2luKGJpdGJha2VfY29uZmRp
ciwgInNpdGUuY29uZiIpCi0gICAgc2l0ZWNvbmYgPSBvcy5wYXRoLm5vcm1wYXRoKG9zLnBhdGgu
am9pbihzZXR1cGRpciwgJy4uJywgInNpdGUuY29uZiIpKQorICAgIGlmIG9zLnBhdGguZXhpc3Rz
KG9zLnBhdGguam9pbihzZXR1cGRpciwgInNpdGUuY29uZiIpKToKKyAgICAgICAgc2l0ZWNvbmYg
PSBvcy5wYXRoLmpvaW4oc2V0dXBkaXIsICJzaXRlLmNvbmYiKQorICAgIGVsc2U6CisgICAgICAg
IHNpdGVjb25mID0gb3MucGF0aC5ub3JtcGF0aChvcy5wYXRoLmpvaW4oc2V0dXBkaXIsICcuLics
ICJzaXRlLmNvbmYiKSkKICAgICBpZiBvcy5wYXRoLmxleGlzdHMoc2l0ZWNvbmZfc3ltbGluayk6
CiAgICAgICAgIG9zLnJlbW92ZShzaXRlY29uZl9zeW1saW5rKQogICAgIG9zLnN5bWxpbmsob3Mu
cGF0aC5yZWxwYXRoKHNpdGVjb25mLCBiaXRiYWtlX2NvbmZkaXIpLCBzaXRlY29uZl9zeW1saW5r
KQpAQCAtODcwLDcgKzg3Myw3IEBAIGRlZiBpbml0X2NvbmZpZyh0b3BfZGlyLCBzZXR0aW5ncywg
YXJncyk6CiAgICAgYmIuZXZlbnQucmVnaXN0ZXIoImJiLmJ1aWxkLlRhc2tQcm9ncmVzcyIsIGhh
bmRsZV90YXNrX3Byb2dyZXNzLCBkYXRhPWQpCiAKICAgICB3cml0ZV91cHN0cmVhbV9jb25maWco
Y29uZmRpciwgdXBzdHJlYW1fY29uZmlnKQotICAgIHVwZGF0ZV9idWlsZCh1cHN0cmVhbV9jb25m
aWcsIGNvbmZkaXIsIHNldHVwZGlyLCBsYXllcmRpciwgZCwgdXBkYXRlX2JiX2NvbmY9InllcyIs
IGluaXRfdnNjb2RlPWFyZ3MuaW5pdF92c2NvZGUpCisgICAgdXBkYXRlX2J1aWxkKHVwc3RyZWFt
X2NvbmZpZywgY29uZmRpciwgc2V0dXBkaXIsIGxheWVyZGlyLCBkLCB1cGRhdGVfYmJfY29uZj1h
cmdzLnVwZGF0ZV9iYl9jb25mLCBpbml0X3ZzY29kZT1hcmdzLmluaXRfdnNjb2RlKQogCiAgICAg
YmIuZXZlbnQucmVtb3ZlKCJiYi5idWlsZC5UYXNrUHJvZ3Jlc3MiLCBOb25lKQogCkBAIC0xMjY4
LDYgKzEyNzEsOCBAQCBkZWYgbWFpbigpOgogICAgICAgICAgICAgICAgICAgICAgICAgaGVscD0n
U3ltbGluayBsb2NhbCBzb3VyY2UgaW50byBhIGJ1aWxkLCBpbnN0ZWFkIG9mIGdldHRpbmcgaXQg
YXMgcHJlc2NyaWJlZCBieSBhIGNvbmZpZ3VyYXRpb24gKHVzZWZ1bCBmb3IgbG9jYWwgZGV2ZWxv
cG1lbnQpLicpCiAgICAgcGFyc2VyX2luaXQuYWRkX2FyZ3VtZW50KCctLWluaXQtdnNjb2RlJywg
YWN0aW9uPWFyZ3BhcnNlLkJvb2xlYW5PcHRpb25hbEFjdGlvbiwgZGVmYXVsdD1ib29sKHNodXRp
bC53aGljaCgnY29kZScpKSwKICAgICAgICAgICAgICAgICAgICAgICAgIGhlbHA9J0dlbmVyYXRl
IFZTQ29kZSB3b3Jrc3BhY2UgY29uZmlndXJhdGlvbiAoZGVmYXVsdDogJShkZWZhdWx0KXMpJykK
KyAgICBwYXJzZXJfaW5pdC5hZGRfYXJndW1lbnQoJy0tdXBkYXRlLWJiLWNvbmYnLCBjaG9pY2Vz
PVsncHJvbXB0JywgJ3llcycsICdubyddLCBkZWZhdWx0PSd5ZXMnLAorICAgICAgICAgICAgICAg
ICAgICAgICAgaGVscD0nVXBkYXRlIGJpdGJha2UgY29uZmlndXJhdGlvbiBmaWxlcyAoYmJsYXll
cnMuY29uZiwgbG9jYWwuY29uZikgd2hlbiByZS1pbml0aWFsaXppbmcgYW4gZXhpc3Rpbmcgc2V0
dXAgKGRlZmF1bHQ6ICUoZGVmYXVsdClzKScpCiAgICAgcGFyc2VyX2luaXQuc2V0X2RlZmF1bHRz
KGZ1bmM9aW5pdF9jb25maWcpCiAKICAgICBwYXJzZXJfc3RhdHVzID0gc3VicGFyc2Vycy5hZGRf
cGFyc2VyKCdzdGF0dXMnLCBoZWxwPSdDaGVjayBpZiB0aGUgc2V0dXAgbmVlZHMgdG8gYmUgc3lu
Y2hyb25pemVkIHdpdGggY29uZmlndXJhdGlvbicpCg==

--0000000000002f272006559786aa--

