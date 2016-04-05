Return-Path: <Daniel.Klauer@gin.de>
X-Greylist: delayed 4196 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 05 Apr 2016 09:59:19 UTC
Received: from good-out-02.clustermail.de (good-out-02.clustermail.de
	[212.223.35.18])
	by mail.openembedded.org (Postfix) with ESMTP id 83B5977101
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  5 Apr 2016 09:59:19 +0000 (UTC)
Received: from frontend-06 ([10.0.0.6] helo=frontend.clustermail.de)
	by smtpout-01.clustermail.de with esmtps
	(TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256) (Exim 4.84)
	(envelope-from <Daniel.Klauer@gin.de>) id 1anMfl-0006l8-9b
	for bitbake-devel@lists.openembedded.org;
	Tue, 05 Apr 2016 10:49:22 +0200
Received: from [217.6.33.234] (helo=Win2012-02.gin-domain.local)
	by frontend.clustermail.de with esmtpsa (TLSv1.2:AES256-SHA:256)
	(Exim 4.84) (envelope-from <Daniel.Klauer@gin.de>)
	id 1anMfl-00043R-3x for bitbake-devel@lists.openembedded.org;
	Tue, 05 Apr 2016 10:49:17 +0200
Received: from Win2012-02.gin-domain.local (192.168.1.12) by
	Win2012-02.gin-domain.local (192.168.1.12) with Microsoft SMTP Server
	(TLS) id 15.0.1130.7; Tue, 5 Apr 2016 10:49:16 +0200
Received: from Win2012-02.gin-domain.local ([fe80::3db4:55fd:d76e:9d90]) by
	Win2012-02.gin-domain.local ([fe80::3db4:55fd:d76e:9d90%12]) with mapi
	id 15.00.1130.005; Tue, 5 Apr 2016 10:49:16 +0200
From: "Klauer, Daniel" <Daniel.Klauer@gin.de>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH] persist_data: Return str instead of unicode for sqlite3
	text queries
Thread-Index: AQHRjxgIh2eNybjGkke7h15zLvzTWw==
Date: Tue, 5 Apr 2016 08:49:15 +0000
Message-ID: <327956a38ac84520a444c9003c494266@Win2012-02.gin-domain.local>
Accept-Language: en-US, de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.1.219]
x-brightmail-tracker: H4sIAAAAAAAAC+NgFnrNqsTGxXJgBSOPLk8Nc7jBug8vDrJb3L92msWBMYAhijUzLym/IoE14/a77UwFm20rpsybydrAeNyqi5GLQ0hgN6PEuy0rWCCcE4wSTQsnAzmcHMwCphJXvjZC2YoSF+41gNlsAroS59rfs4LYIgLBEutW9TCB2MIC4RL3nxxmhojHSCy+0ccIYetJdG1uArMlBHQk/i5qBOrl4GARUJE4N8cOJMwr4CUx7d0JsDGMArISnQ3vmCDWikvcejKfCaJVQGLJnvPMELaSRO9tkBoOIDtE4sVRIYgxghInZz5hgSgxk9j7YAlUq67Et2OboeKBEk+b9rBDtJpKXH0fDBE2kHi39jNUibHEyo3/oQ62ldgzYyLUJmeJeTfqIcJOEm863rJC2NoS21/tY4X5b9O1VVBj5CX+37sPZTtKXHnXzwZhK0p8ut3ENoFRbRZSMM9CCuZZSH6fheSxBYwsqxilwzPzjAwMjXQNjPTSM/N0U/JzEzPz9HLykxNzNjFCE8IOxkefXQ8xSnIwKYnyXipgDhfiS8pPqcxILM6ILyrNSS0+xCjBwaMkwmtcBZTjLS5IzC3OTIdJyXBwKEnwXq8ESgkWpaanVqRl5pSkFkGkTzFKSonzCoP0CYD0ZZTmweUuMYpKCfNeBmnkKUgtys0sgYjfYhTmeMgkxJKXn5cqBXQiAxBoML5iFOdgVBLmlQCZxZOZVwJ3wiug65iArqsXZgK5riQRISXVwDj1kPXyhHe+9qabnHl2mCb3JZ8pbrrYemptlEAr3/7Ne09UWIi6ddftvDpj0paGbWF9vLM+qc5b0l97L0SBbeWheS7Ba8OzdTR+5fJNPq7Bv6Dzn99z5t1fkzqXrz75Rfjkkd8bnA7P+jZX5YvShUepV1cmy+5ll3vVEda3vTfc9+OexAe/U0qVWIozEg21mIuKEwFoE2cjfgMAAA==
MIME-Version: 1.0
Subject: [PATCH] persist_data: Return str instead of unicode for sqlite3 text queries
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
X-List-Received-Date: Tue, 05 Apr 2016 09:59:19 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Python 2's sqlite3 module defaults to returning Unicode strings for SQL=0A=
text queries, which could trickle down to other parts of bitbake code and=
=0A=
cause unexpected Unicode conversions. Using byte strings avoids this issue.=
=0A=
=0A=
For example, the git fetcher's AUTOREV support caches HEAD SHA1's using=0A=
bb.persist_data, so sometimes the git command strings passed to fetch2's=0A=
runfetchcmd() were unicode, potentially causing UnicodeDecodeErrors when=0A=
it appended the values of environment variables containing non-ASCII chars.=
=0A=
=0A=
[YOCTO #9382]=0A=
=0A=
Signed-off-by: Daniel Klauer <daniel.klauer@gin.de>=0A=
---=0A=
 lib/bb/persist_data.py | 1 +=0A=
 1 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/lib/bb/persist_data.py b/lib/bb/persist_data.py=0A=
index 5795bc8..e450423 100644=0A=
--- a/lib/bb/persist_data.py=0A=
+++ b/lib/bb/persist_data.py=0A=
@@ -201,6 +201,7 @@ class PersistData(object):=0A=
 def connect(database):=0A=
     connection =3D sqlite3.connect(database, timeout=3D5, isolation_level=
=3DNone)=0A=
     connection.execute("pragma synchronous =3D off;")=0A=
+    connection.text_factory =3D str=0A=
     return connection=0A=
 =0A=
 def persist(domain, d):=0A=
-- =0A=
1.9.1=0A=

