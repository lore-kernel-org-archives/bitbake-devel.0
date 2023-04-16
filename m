Return-Path: <public@smn.dk>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C59BC77B61
	for <webhook@archiver.kernel.org>; Sun, 16 Apr 2023 19:56:58 +0000 (UTC)
Subject: [PATCH] Recipes containing both git and npmsw sources in the SRC_URI fail during fetch from the shrinkwrap. It seems that when the fetcher is fetching from the shrinkwrap, the SRCREV variable has been deleted but it still ends up fetching from the git source resulting in an error because SRCREV is undefined. The root cause of this is that the Fetch class defaults to urls from the SRC_URI when the urls parameter contains an empty list. This patch will ensure that Fetch is not instantiated if the urls list is empty.
To: bitbake-devel@lists.openembedded.org
From: public@smn.dk
X-Originating-Location: Birkerød, Capital Region, DK (130.228.29.38)
X-Originating-Platform: Windows Chrome 112
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Sun, 16 Apr 2023 12:56:52 -0700
Message-ID: <hd1M.1681675012932104736.XKYK@lists.openembedded.org>
Content-Type: multipart/mixed; boundary="VfpWm0gDele1PbNWGU66"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 16 Apr 2023 19:56:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14705

--VfpWm0gDele1PbNWGU66
Content-Type: multipart/alternative; boundary="98jJfQ3WfSr5cp81qDdk"

--98jJfQ3WfSr5cp81qDdk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

[PATCH] Recipes containing both git and npmsw sources in the SRC_URI fail d=
uring fetch from the shrinkwrap. It seems that when the fetcher is fetching=
 from the shrinkwrap, the SRCREV variable has been deleted but it still end=
s up fetching from the git source resulting in an error because SRCREV is u=
ndefined. The root cause of this is that the Fetch class defaults to urls f=
rom the SRC_URI when the urls parameter contains an empty list. This patch =
will ensure that Fetch is not instantiated if the urls list is empty.

--98jJfQ3WfSr5cp81qDdk
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

[PATCH] Recipes containing both git and npmsw sources in the SRC_URI fail d=
uring fetch from the shrinkwrap. It seems that when the fetcher is fetching=
 from the shrinkwrap, the SRCREV variable has been deleted but it still end=
s up fetching from the git source resulting in an error because SRCREV is u=
ndefined. The root cause of this is that the Fetch class defaults to urls f=
rom the SRC_URI when the urls parameter contains an empty list. This patch =
will ensure that Fetch is not instantiated if the urls list is empty.

--98jJfQ3WfSr5cp81qDdk--

--VfpWm0gDele1PbNWGU66
Content-Type: application/octet-stream; name="0001-Recipes-containing-both-git-and-npmsw-sources-in-the.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-Recipes-containing-both-git-and-npmsw-sources-in-the.patch"

RnJvbSA1NmE2ZTk3ODdhODdmNTdiOWNjOWRhMGY2ZjY0YWJjZDhhNGE0YTlhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdmVuZCBNZXlsYW5kIE5pY29sYWlzZW4gPHN2ZW5kLm5pY29s
YWlzZW5Abmt0cGhvdG9uaWNzLmNvbT4KRGF0ZTogU3VuLCAxNiBBcHIgMjAyMyAwMTo0MjoyNCAr
MDIwMApTdWJqZWN0OiBbUEFUQ0hdIFJlY2lwZXMgY29udGFpbmluZyBib3RoIGdpdCBhbmQgbnBt
c3cgc291cmNlcyBpbiB0aGUgU1JDX1VSSQogZmFpbCBkdXJpbmcgZmV0Y2ggZnJvbSB0aGUgc2hy
aW5rd3JhcC4gSXQgc2VlbXMgdGhhdCB3aGVuIHRoZSBmZXRjaGVyIGlzCiBmZXRjaGluZyBmcm9t
IHRoZSBzaHJpbmt3cmFwLCB0aGUgU1JDUkVWIHZhcmlhYmxlIGhhcyBiZWVuIGRlbGV0ZWQgYnV0
IGl0CiBzdGlsbCBlbmRzIHVwIGZldGNoaW5nIGZyb20gdGhlIGdpdCBzb3VyY2UgcmVzdWx0aW5n
IGluIGFuIGVycm9yIGJlY2F1c2UKIFNSQ1JFViBpcyB1bmRlZmluZWQuIFRoZSByb290IGNhdXNl
IG9mIHRoaXMgaXMgdGhhdCB0aGUgRmV0Y2ggY2xhc3MgZGVmYXVsdHMKIHRvIHVybHMgZnJvbSB0
aGUgU1JDX1VSSSB3aGVuIHRoZSB1cmxzIHBhcmFtZXRlciBjb250YWlucyBhbiBlbXB0eSBsaXN0
LiBUaGlzCiBwYXRjaCB3aWxsIGVuc3VyZSB0aGF0IEZldGNoIGlzIG5vdCBpbnN0YW50aWF0ZWQg
aWYgdGhlIHVybHMgbGlzdCBpcyBlbXB0eS4KClNpZ25lZC1vZmYtYnk6IFN2ZW5kIE1leWxhbmQg
Tmljb2xhaXNlbiA8c3ZlbmQubmljb2xhaXNlbkBua3RwaG90b25pY3MuY29tPgotLS0KIGxpYi9i
Yi9mZXRjaDIvbnBtc3cucHkgfCA0ICsrKy0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9saWIvYmIvZmV0Y2gyL25wbXN3LnB5IGIv
bGliL2JiL2ZldGNoMi9ucG1zdy5weQppbmRleCAzNmZjYmZiYS4uY2M4MTEwMGIgMTAwNjQ0Ci0t
LSBhL2xpYi9iYi9mZXRjaDIvbnBtc3cucHkKKysrIGIvbGliL2JiL2ZldGNoMi9ucG1zdy5weQpA
QCAtMjA1LDcgKzIwNSw5IEBAIGNsYXNzIE5wbVNocmlua1dyYXAoRmV0Y2hNZXRob2QpOgogICAg
ICAgICAjIFRoaXMgZmV0Y2hlciByZXNvbHZlcyBtdWx0aXBsZSBVUklzIGZyb20gYSBzaHJpbmt3
cmFwIGZpbGUgYW5kIHRoZW4KICAgICAgICAgIyBmb3J3YXJkcyBpdCB0byBhIHByb3h5IGZldGNo
ZXIuIFRoZSBtYW5hZ2VtZW50IG9mIHRoZSBkb25lc3RhbXAgZmlsZSwKICAgICAgICAgIyB0aGUg
bG9ja2ZpbGUgYW5kIHRoZSBjaGVja3N1bXMgYXJlIGZvcndhcmRlZCB0byB0aGUgcHJveHkgZmV0
Y2hlci4KLSAgICAgICAgdWQucHJveHkgPSBGZXRjaChbZGVwWyJ1cmwiXSBmb3IgZGVwIGluIHVk
LmRlcHMgaWYgZGVwWyJ1cmwiXV0sIGRhdGEpCisgICAgICAgIHNocmlua3dyYXBfdXJscyA9IFtk
ZXBbInVybCJdIGZvciBkZXAgaW4gdWQuZGVwcyBpZiBkZXBbInVybCJdXQorICAgICAgICBpZiBz
aHJpbmt3cmFwX3VybHM6CisgICAgICAgICAgICB1ZC5wcm94eSA9IEZldGNoKHNocmlua3dyYXBf
dXJscywgZGF0YSkKICAgICAgICAgdWQubmVlZGRvbmVzdGFtcCA9IEZhbHNlCiAKICAgICBAc3Rh
dGljbWV0aG9kCi0tIAoyLjM5LjIud2luZG93cy4xCgo=

--VfpWm0gDele1PbNWGU66--

