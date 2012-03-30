Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <oren@ephemeron-labs.com>) id 1SDVRa-0004m2-Ca
	for bitbake-devel@lists.openembedded.org;
	Fri, 30 Mar 2012 08:36:18 +0200
Received: by obbwc20 with SMTP id wc20so557792obb.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Mar 2012 23:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=mime-version:x-originating-ip:date:message-id:subject:from:to
	:x-gm-message-state:content-type;
	bh=FAHzhm9jDkExgiFBldvgBBtiGvp0FYGmkKykA+3ve8k=;
	b=FgApiX0E5xeXLBTh74U0C9bwVcEWUGZebyzXBz1d/BV/WKFX6AlAT67TXRH9Hut2ep
	glu+hjD13lWIGwDKtS2gg8CUlmqJ2NaDlgyYracIs/PWt7Uira7dUOHI3u1ymsK8tKce
	ymQdQe0nF0NeNyTa509zSsdfi92sxk9Le4aaoOt8c55NqM7gghdNpj9lkEyohH/TzLnK
	H0rG2HmXpjOKqvY8UTrDwly4F9CKalqDhJ8YWD2zAlneoZrlPteYDcrYP/Cjx1NdhRns
	4iy4nSWlBR1tggupnzVeWcCukin/i+ButVgPVt95wU0jYBF4z5PXkm+siT0mnjd5iAQk
	IJ9w==
MIME-Version: 1.0
Received: by 10.182.147.35 with SMTP id th3mr1004149obb.29.1333088833805; Thu,
	29 Mar 2012 23:27:13 -0700 (PDT)
Received: by 10.182.98.65 with HTTP; Thu, 29 Mar 2012 23:27:13 -0700 (PDT)
X-Originating-IP: [76.99.59.229]
Date: Fri, 30 Mar 2012 02:27:13 -0400
Message-ID: <CALvD2Lj2HbbAmfsaQyiifz5DLe+3-ewX7TPBAkFGJRxSp2_P5w@mail.gmail.com>
From: Oren Leaffer <oren@ephemeron-labs.com>
To: bitbake-devel@lists.openembedded.org
X-Gm-Message-State: ALoCoQmjwkuMMow85p2iVB2oLhY3amRuyaKSWqzuyF+BpVcBIouOYnjgZvJ4QrBP5iTIKRC33R85
Subject: do_rootfs failed ... bug in log_check?
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 30 Mar 2012 06:36:18 -0000
X-Groupsio-MsgNum: 1649
Content-Type: multipart/mixed; boundary=f46d04440054649cc104bc6fee1d

--f46d04440054649cc104bc6fee1d
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I'm getting the following failure on "bitbake -v -D -D -D systemd-image":
ERROR: Task 8 (/home/ol/setup-scripts/sources/meta-angstrom/recipes-images/angstrom/systemd-image.bb,
do_rootfs) failed with exit code '1'
NOTE: Tasks Summary: Attempted 3283 tasks of which 3282 didn't need to
be rerun and 1 failed.
+ cd /home/ol/setup-scripts/build/tmp-angstrom_2010_x-eglibc/work/armv7a-angstrom-linux-gnueabi/bblayers-1.0-r0/bblayers-1.0
+ buildhistory_commit
+ '[' '!' -d /home/ol/setup-scripts/build/tmp-angstrom_2010_x-eglibc/buildhistory
']'
+ cd /home/ol/setup-scripts/build/tmp-angstrom_2010_x-eglibc/buildhistory/
+ '[' '!' -d .git ']'
++ git status --porcelain
+ repostatus=
+ '[' '' '!=' '' ']'

From what I can tell, this is caused because the log_check command in
setup-scripts/sources/openembedded-core/meta/classes/package_ipk.class
matches on line 177 to

file://3.2.1/0042-xhci-Properly-handle-COMP_2ND_BW_ERR.patch

and to

file://3.2.6/0072-target-Fail-INQUIRY-commands-with-EVPD-0-but-PAGE-CO.patch

It occurs to me that this might be a result of the level of
verbosity/debugging that I specified.

Attached is my patch that does two things:
1) makes the error message from log_check slightly more informative
2) changes the text that log_check is using to identify errors to
incorporate regular expressions

This makes it less likely to issue false positives, I hope that it
doesn't increase the changes of false negatives, but I'm a rank
amateur at this, so I wouldn't bet on it.


Best regards,


Oren

--f46d04440054649cc104bc6fee1d
Content-Type: application/octet-stream; 
	name="0001-making-log_check-less-likely-to-declare-failure-inco.patch"
Content-Disposition: attachment; 
	filename="0001-making-log_check-less-likely-to-declare-failure-inco.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h0eul9nl0

RnJvbSAzZmFjMmJjNzk4NjA3ZWFiY2U0MGY2MTE1OTZhNGJkODk1MTAyZmI4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBPcmVuIExlYWZmZXIgPG9yZW5AZXBoZW1lcm9uLWxhYnMuY29t
PgpEYXRlOiBGcmksIDMwIE1hciAyMDEyIDAyOjIzOjM1IC0wNDAwClN1YmplY3Q6IFtQQVRDSF0g
bWFraW5nIGxvZ19jaGVjayBsZXNzIGxpa2VseSB0byBkZWNsYXJlIGZhaWx1cmUgaW5jb3JyZWN0
bHkKCi0tLQogbWV0YS9jbGFzc2VzL3BhY2thZ2VfZGViLmJiY2xhc3MgfCAgICA0ICsrLS0KIG1l
dGEvY2xhc3Nlcy9wYWNrYWdlX2lway5iYmNsYXNzIHwgICAgNiArKystLS0KIG1ldGEvY2xhc3Nl
cy9wYWNrYWdlX3JwbS5iYmNsYXNzIHwgICAgNCArKy0tCiAzIGZpbGVzIGNoYW5nZWQsIDcgaW5z
ZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9tZXRhL2NsYXNzZXMvcGFj
a2FnZV9kZWIuYmJjbGFzcyBiL21ldGEvY2xhc3Nlcy9wYWNrYWdlX2RlYi5iYmNsYXNzCmluZGV4
IDFmN2VjOWMuLjc4YzAzMmUgMTAwNjQ0Ci0tLSBhL21ldGEvY2xhc3Nlcy9wYWNrYWdlX2RlYi5i
YmNsYXNzCisrKyBiL21ldGEvY2xhc3Nlcy9wYWNrYWdlX2RlYi5iYmNsYXNzCkBAIC0xOTEsOCAr
MTkxLDggQEAgZGViX2xvZ19jaGVjaygpIHsKIAlkbwogCQlpZiAoZWNobyAiJGxmX3R4dCIgfCBn
cmVwIC12IGxvZ19jaGVjayB8IGdyZXAgIiRrZXl3b3JkX2RpZSIpID4vZGV2L251bGwgMj4mMQog
CQl0aGVuCi0JCQllY2hvICJsb2dfY2hlY2s6IFRoZXJlIHdlcmUgZXJyb3IgbWVzc2FnZXMgaW4g
dGhlIGxvZ2ZpbGUiCi0JCQllY2hvIC1lICJsb2dfY2hlY2s6IE1hdGNoZWQga2V5d29yZDogWyRr
ZXl3b3JkX2RpZV1cbiIKKwkJCWVjaG8gImRlYl9sb2dfY2hlY2s6IFRoZXJlIHdlcmUgZXJyb3Ig
bWVzc2FnZXMgaW4gdGhlIGxvZ2ZpbGUiCisJCQllY2hvIC1lICJkZWJfbG9nX2NoZWNrOiBNYXRj
aGVkIGtleXdvcmQ6IFska2V5d29yZF9kaWVdXG4iCiAJCQllY2hvICIkbGZfdHh0IiB8IGdyZXAg
LXYgbG9nX2NoZWNrIHwgZ3JlcCAtQyA1IC1pICIka2V5d29yZF9kaWUiCiAJCQllY2hvICIiCiAJ
CQlkb19leGl0PTEKZGlmZiAtLWdpdCBhL21ldGEvY2xhc3Nlcy9wYWNrYWdlX2lway5iYmNsYXNz
IGIvbWV0YS9jbGFzc2VzL3BhY2thZ2VfaXBrLmJiY2xhc3MKaW5kZXggNTY1ZWY5My4uOGM1MTFj
MSAxMDA2NDQKLS0tIGEvbWV0YS9jbGFzc2VzL3BhY2thZ2VfaXBrLmJiY2xhc3MKKysrIGIvbWV0
YS9jbGFzc2VzL3BhY2thZ2VfaXBrLmJiY2xhc3MKQEAgLTE3NCwxMiArMTc0LDEyIEBAIGlwa19s
b2dfY2hlY2soKSB7CiAgICAgICAgbGZfcGF0aD0iJDIiCiAKICAgICAgICBsZl90eHQ9ImBjYXQg
JGxmX3BhdGhgIgotICAgICAgIGZvciBrZXl3b3JkX2RpZSBpbiAiZXhpdCAxIiAiQ29sbGVjdGVk
IGVycm9ycyIgRVJSIEZhaWwKKyAgICAgICBmb3Iga2V5d29yZF9kaWUgaW4gImV4aXQgMSIgIkNv
bGxlY3RlZCBlcnJvcnMiICJeRVJSIiAiXkZhaWwgIgogICAgICAgIGRvCiAgICAgICAgICAgICAg
ICBpZiAoZWNobyAiJGxmX3R4dCIgfCBncmVwIC12IGxvZ19jaGVjayB8IGdyZXAgIiRrZXl3b3Jk
X2RpZSIpID4vZGV2L251bGwgMj4mMQogICAgICAgICAgICAgICAgdGhlbgotICAgICAgICAgICAg
ICAgICAgICAgICBlY2hvICJsb2dfY2hlY2s6IFRoZXJlIHdlcmUgZXJyb3IgbWVzc2FnZXMgaW4g
dGhlIGxvZ2ZpbGUiCi0gICAgICAgICAgICAgICAgICAgICAgIGVjaG8gLWUgImxvZ19jaGVjazog
TWF0Y2hlZCBrZXl3b3JkOiBbJGtleXdvcmRfZGllXVxuIgorICAgICAgICAgICAgICAgICAgICAg
ICBlY2hvICJpcGtfbG9nX2NoZWNrOiBUaGVyZSB3ZXJlIGVycm9yIG1lc3NhZ2VzIGluIHRoZSBs
b2dmaWxlIgorICAgICAgICAgICAgICAgICAgICAgICBlY2hvIC1lICJpcGtfbG9nX2NoZWNrOiBN
YXRjaGVkIGtleXdvcmQ6IFska2V5d29yZF9kaWVdXG4iCiAgICAgICAgICAgICAgICAgICAgICAg
IGVjaG8gIiRsZl90eHQiIHwgZ3JlcCAtdiBsb2dfY2hlY2sgfCBncmVwIC1DIDUgLWkgIiRrZXl3
b3JkX2RpZSIKICAgICAgICAgICAgICAgICAgICAgICAgZWNobyAiIgogICAgICAgICAgICAgICAg
ICAgICAgICBkb19leGl0PTEKZGlmZiAtLWdpdCBhL21ldGEvY2xhc3Nlcy9wYWNrYWdlX3JwbS5i
YmNsYXNzIGIvbWV0YS9jbGFzc2VzL3BhY2thZ2VfcnBtLmJiY2xhc3MKaW5kZXggMGNjZjU3NC4u
YzAxNGEzOCAxMDA2NDQKLS0tIGEvbWV0YS9jbGFzc2VzL3BhY2thZ2VfcnBtLmJiY2xhc3MKKysr
IGIvbWV0YS9jbGFzc2VzL3BhY2thZ2VfcnBtLmJiY2xhc3MKQEAgLTExOSw4ICsxMTksOCBAQCBy
cG1fbG9nX2NoZWNrKCkgewogICAgICAgIGRvCiAgICAgICAgICAgICAgICBpZiAoZWNobyAiJGxm
X3R4dCIgfCBncmVwIC12IGxvZ19jaGVjayB8IGdyZXAgIiRrZXl3b3JkX2RpZSIpID4vZGV2L251
bGwgMj4mMQogICAgICAgICAgICAgICAgdGhlbgotICAgICAgICAgICAgICAgICAgICAgICBlY2hv
ICJsb2dfY2hlY2s6IFRoZXJlIHdlcmUgZXJyb3IgbWVzc2FnZXMgaW4gdGhlIGxvZ2ZpbGUiCi0g
ICAgICAgICAgICAgICAgICAgICAgIGVjaG8gLWUgImxvZ19jaGVjazogTWF0Y2hlZCBrZXl3b3Jk
OiBbJGtleXdvcmRfZGllXVxuIgorICAgICAgICAgICAgICAgICAgICAgICBlY2hvICJycG1fbG9n
X2NoZWNrOiBUaGVyZSB3ZXJlIGVycm9yIG1lc3NhZ2VzIGluIHRoZSBsb2dmaWxlIgorICAgICAg
ICAgICAgICAgICAgICAgICBlY2hvIC1lICJycG1fbG9nX2NoZWNrOiBNYXRjaGVkIGtleXdvcmQ6
IFska2V5d29yZF9kaWVdXG4iCiAgICAgICAgICAgICAgICAgICAgICAgIGVjaG8gIiRsZl90eHQi
IHwgZ3JlcCAtdiBsb2dfY2hlY2sgfCBncmVwIC1DIDUgLWkgIiRrZXl3b3JkX2RpZSIKICAgICAg
ICAgICAgICAgICAgICAgICAgZWNobyAiIgogICAgICAgICAgICAgICAgICAgICAgICBkb19leGl0
PTEKLS0gCjEuNy4wLjQKCg==

--f46d04440054649cc104bc6fee1d--
