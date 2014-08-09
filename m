Return-Path: <ma5645@gmail.com>
Received: from mail-qg0-f52.google.com (mail-qg0-f52.google.com
	[209.85.192.52])
	by mail.openembedded.org (Postfix) with ESMTP id C192670A73
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  9 Aug 2014 20:02:20 +0000 (UTC)
Received: by mail-qg0-f52.google.com with SMTP id f51so7171180qge.39
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 09 Aug 2014 13:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=sender:from:content-type:subject:message-id:date:to:mime-version;
	bh=0LGOh42in9m0bnRgvEw6t8E+kVVRer+jE9HDpBjS7Ck=;
	b=CKHtLGQeT350yHyB2334B1H/zYcbJjPIooEno81sbft+bDD6XhHntdQU2M4x4e4fMp
	BzYSa1KzVstPnnYrrK5i2jHvmI7MdbrXuK/++FUNJwlo8ZpQdxfqHSANaka+xGlzO6Wj
	V30jTKqZw3kDTu5qigcGlhZNcRWhk+KprRDEHIQ9bCNOp/8h56AQvM07YyyjPPTocq3D
	HSgIEFhjJ0bALlFR+UZwIVGYbaWmQmR/j9rvKBNuuti4YP7azE/DAJmbSL/wG4swI1rS
	AhAS5rsGzDcmw2atmUmHy3ZDN26j7IxgV6GaMDFuoYWhMtptoRYO3gL+bn+g5AhNRh+a
	HH5Q==
X-Received: by 10.229.38.3 with SMTP id z3mr48902913qcd.17.1407614541434;
	Sat, 09 Aug 2014 13:02:21 -0700 (PDT)
Received: from [192.168.1.151] (modemcable250.171-70-69.static.videotron.ca.
	[69.70.171.250])
	by mx.google.com with ESMTPSA id p46sm8073712qgd.11.2014.08.09.13.02.19
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Sat, 09 Aug 2014 13:02:19 -0700 (PDT)
Sender: Michael Andronov <ma5645@gmail.com>
From: Michael Andronov <michael_andronov@sd-kyber.com>
Message-Id: <8DF7A968-116B-4A13-8D17-E8DEACFDDC77@sd-kyber.com>
Date: Sat, 9 Aug 2014 16:02:16 -0400
To: bitbake-devel@lists.openembedded.org
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1972.3\))
X-Mailer: Apple Mail (2.1972.3)
Subject: fetching from bzr...
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
X-List-Received-Date: Sat, 09 Aug 2014 20:02:33 -0000
X-Groupsio-MsgNum: 4956
Content-Type: multipart/signed;
	boundary="Apple-Mail=_51DCE673-FF7A-4BB8-A5E7-123786272E6B";
	protocol="application/pkcs7-signature"; micalg=sha1

--Apple-Mail=_51DCE673-FF7A-4BB8-A5E7-123786272E6B
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_688444A5-23CD-4F15-AAAE-0CABFF576BE0"

--Apple-Mail=_688444A5-23CD-4F15-AAAE-0CABFF576BE0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

It is kind of a newbie question:

While using Bitbake (Yocto), I need to fetch the code from bzr =
repository.=20

Let say, that my =E2=80=98regular=E2=80=99   process of getting source =
code from my server is:
=E2=80=98 bzr branch sftp://michael@192.168.1.150/kernel' =
<sftp://michael@192.168.1.150/kernel'>
 ( And I=E2=80=99m getting on local machine the latest source for  the =
branch)

I=E2=80=99m trying to make the recipe for BitBake to achieve the same =
=E2=80=A6=20
But obviously, I=E2=80=99m doing something wrong, since I=E2=80=99m =
getting Fetcher failure=E2=80=A6=20

I wonder
- is there some example(s) how to set SRC_URI for =E2=80=98bzr://=E2=80=A6=
.' <bzr://%E2%80%A6.'>  ?
- is there some examples ( guidence ) how to trace the =E2=80=A6fetch2/bzr=
.py, in order to get better understanding how the task should be =
setup=E2=80=A6=20

Thank you very much for your kind attention to this matter.=20

Michael.

P.S.   Sorry, if the similar question has been answered already=E2=80=A6. =
Failed to find=E2=80=A6=20=

--Apple-Mail=_688444A5-23CD-4F15-AAAE-0CABFF576BE0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D"">It is kind of a newbie question:<div class=3D""><br =
class=3D""></div><div class=3D"">While using Bitbake (Yocto), I need to =
fetch the code from bzr repository.&nbsp;</div><div class=3D""><br =
class=3D""></div><div class=3D"">Let say, that my =E2=80=98regular=E2=80=99=
 &nbsp; process of getting source code from my server is:</div><div =
class=3D"">=E2=80=98 bzr branch&nbsp;<a =
href=3D"sftp://michael@192.168.1.150/kernel'" =
class=3D"">sftp://michael@192.168.1.150/kernel'</a></div><div =
class=3D"">&nbsp;( And I=E2=80=99m getting on local machine the latest =
source for &nbsp;the branch)</div><div class=3D""><br =
class=3D""></div><div class=3D"">I=E2=80=99m trying to make the recipe =
for BitBake to achieve the same =E2=80=A6&nbsp;</div><div class=3D"">But =
obviously, I=E2=80=99m doing something wrong, since I=E2=80=99m getting =
Fetcher failure=E2=80=A6&nbsp;</div><div class=3D""><br =
class=3D""></div><div class=3D"">I wonder</div><div class=3D"">- is =
there some example(s) how to set SRC_URI for =E2=80=98<a =
href=3D"bzr://%E2%80%A6.'" class=3D"">bzr://=E2=80=A6.'</a>&nbsp; =
?</div><div class=3D"">- is there some examples ( guidence ) how to =
trace the =E2=80=A6fetch2/bzr.py, in order to get better understanding =
how the task should be setup=E2=80=A6&nbsp;</div><div class=3D""><br =
class=3D""></div><div class=3D"">Thank you very much for your kind =
attention to this matter.&nbsp;</div><div class=3D""><br =
class=3D""></div><div class=3D"">Michael.</div><div class=3D""><br =
class=3D""></div><div class=3D"">P.S. &nbsp; Sorry, if the similar =
question has been answered already=E2=80=A6. Failed to =
find=E2=80=A6&nbsp;</div></body></html>=

--Apple-Mail=_688444A5-23CD-4F15-AAAE-0CABFF576BE0--

--Apple-Mail=_51DCE673-FF7A-4BB8-A5E7-123786272E6B
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIEEzCCBA8w
ggL3oAMCAQICAQEwCwYJKoZIhvcNAQEFMIGoMRkwFwYDVQQDDBBNaWNoYWVsIEFuZHJvbm92MSww
KgYDVQQKDCNTeXN0w6htZXMgRCdJbnRlZ3JhdGlvbiBLeWJlciwgSW5jLjEPMA0GA1UECAwGUXVl
YmVjMQswCQYDVQQGEwJDQTERMA8GA1UEBwwITW9udHJlYWwxLDAqBgkqhkiG9w0BCQEWHW1pY2hh
ZWxfYW5kcm9ub3ZAc2Qta3liZXIuY29tMB4XDTEwMDEwNTIyNDQxMFoXDTI5MTIzMTIyNDQxMFow
gagxGTAXBgNVBAMMEE1pY2hhZWwgQW5kcm9ub3YxLDAqBgNVBAoMI1N5c3TDqG1lcyBEJ0ludGVn
cmF0aW9uIEt5YmVyLCBJbmMuMQ8wDQYDVQQIDAZRdWViZWMxCzAJBgNVBAYTAkNBMREwDwYDVQQH
DAhNb250cmVhbDEsMCoGCSqGSIb3DQEJARYdbWljaGFlbF9hbmRyb25vdkBzZC1reWJlci5jb20w
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCu8FskUG4wyY44rTUTtM5UWplSGl2Sl07P
ymeLq7HF++riCWGBSMoV+XC8o+lsKkdYeAJYEoKAR2EAgt2EtHmD/Fmfm9Skanh5sWpaphgm7Pr4
CT6iFdrZEyTpi3/9PTbr/qt0uUHLkg48LAMftHQW55ZRDcL/3HiAItjvCtQI0UC5jI8uHCJV3KOj
LRvjn2xh3l0LMBbwa5UEDj3/44YDQE5QOBLzmdfVHOR7mICwu9J/m+3lYCb4EKdvy3alo78NcLFC
UkRcY3zJ4kgD2Q0/lPpiAMnQ3KQtYvqd153QIdoOzmuJkXWXSgnNDRenlnGRvnFEwL69xUMm+5n8
AJu7AgMBAAGjRDBCMEAGA1UdEQQ5MDeGJ2h0dHA6Ly9zZC1reWJlci5jb20vcmVzb3VyY2UvbWlj
aGFlbGEjaYIMc2Qta3liZXIuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQA/q//57bR9w28nGNkpRlV2
0lJUmGnT0pgi+GuCqbgpgYO3aTy7f3rR1G2SA35m3vBvwFpXY6LYNQQDDH1Z2Bxja1nmWhkT+PEL
dNHpl2gcS232KoLMIvEOdlEs6HIVVqj8ZvVKKjFoRjOWQQDED8FFjdJtAWxLWaCtLjJPerjhf8YB
gcm/bdfjZrs7wWInwkEUFDk+bp+xir6Tvrnu6XvYDoNFmoPQRaTH2wpJBP7i+kVtD8IYk+tj8/lJ
0TESYGgsGeILVpuWJ+8oeh46rLuLQ42TOBM1rE6dThagFMKiY+RZmDr/QTdL7OP5pYnveFbZ1noM
+6abHMqo4W7digElMYIDvTCCA7kCAQEwga4wgagxGTAXBgNVBAMMEE1pY2hhZWwgQW5kcm9ub3Yx
LDAqBgNVBAoMI1N5c3TDqG1lcyBEJ0ludGVncmF0aW9uIEt5YmVyLCBJbmMuMQ8wDQYDVQQIDAZR
dWViZWMxCzAJBgNVBAYTAkNBMREwDwYDVQQHDAhNb250cmVhbDEsMCoGCSqGSIb3DQEJARYdbWlj
aGFlbF9hbmRyb25vdkBzZC1reWJlci5jb20CAQEwCQYFKw4DAhoFAKCCAeMwGAYJKoZIhvcNAQkD
MQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTQwODA5MjAwMjE2WjAjBgkqhkiG9w0BCQQx
FgQU7LOYmHGiZcHXDL4S37jwWpuRCVswgb8GCSsGAQQBgjcQBDGBsTCBrjCBqDEZMBcGA1UEAwwQ
TWljaGFlbCBBbmRyb25vdjEsMCoGA1UECgwjU3lzdMOobWVzIEQnSW50ZWdyYXRpb24gS3liZXIs
IEluYy4xDzANBgNVBAgMBlF1ZWJlYzELMAkGA1UEBhMCQ0ExETAPBgNVBAcMCE1vbnRyZWFsMSww
KgYJKoZIhvcNAQkBFh1taWNoYWVsX2FuZHJvbm92QHNkLWt5YmVyLmNvbQIBATCBwQYLKoZIhvcN
AQkQAgsxgbGgga4wgagxGTAXBgNVBAMMEE1pY2hhZWwgQW5kcm9ub3YxLDAqBgNVBAoMI1N5c3TD
qG1lcyBEJ0ludGVncmF0aW9uIEt5YmVyLCBJbmMuMQ8wDQYDVQQIDAZRdWViZWMxCzAJBgNVBAYT
AkNBMREwDwYDVQQHDAhNb250cmVhbDEsMCoGCSqGSIb3DQEJARYdbWljaGFlbF9hbmRyb25vdkBz
ZC1reWJlci5jb20CAQEwDQYJKoZIhvcNAQEBBQAEggEAeNbyT4vLyLhEpfl1Vay7tAMcsg/6Y9c4
H9x3mS9ziA4BY8BZezzxQMPMQvi9+YnA/57IIpiIELiDc20r7/y0R61w2pCJkS2kUwjVhgieJqf9
BMOKy7CD9YPG0hwBR/dOHZDMS5wqKrE4T0ofZPa7AOtg6zHQGgj43iC6W3RDnoMZNU7fiNZfu7ar
3eTyKDZbVQpOmOrmgCbwQ2+tRewVyliEqP6v3+jEyYs9sA/yYnKXufIVSe24cCZ4rxHwCQJrBJip
XuR3EMR3F8JX1iPZM1xpWooyXAIEf95mAHrzIxGsrGOmsIJenykwH4YswOppCJAoUsAIeBUN06zh
RjRFggAAAAAAAA==

--Apple-Mail=_51DCE673-FF7A-4BB8-A5E7-123786272E6B--
