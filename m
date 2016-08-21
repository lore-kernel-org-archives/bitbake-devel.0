Return-Path: <zzs213@126.com>
Received: from m15-111.126.com (m15-111.126.com [220.181.15.111])
	by mail.openembedded.org (Postfix) with ESMTP id 35E107318E
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 21 Aug 2016 16:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Message-ID:Date:MIME-Version; bh=5K/zf
	HPLrgnwBfflJhEF40JTXZS+00fQALEVS6cnsqo=; b=RM0kPmJSO8O0dC2VJW0Ak
	Qv8g/n57tBkKHziN7p6dvSmvJ14mEueyPDiCV8RumATVWcdZ7Bd+0iIYBS+SvNK2
	5ZKmwZym7YYNjNINph/UqIfBgNoP9vYqUQJlFXJWxu81tAJ4DWlNKps4OryDV4dQ
	ULGp/RLBnpQVp10UD94grw=
Received: from [192.168.0.12] (unknown [171.212.168.219])
	by smtp1 (Coremail) with SMTP id C8mowAD3_y_qzLlXLae+Dg--.8552S2;
	Sun, 21 Aug 2016 23:46:52 +0800 (CST)
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
From: =?UTF-8?B?5byg5b+g5bGx?= <zzs213@126.com>
Message-ID: <0c2145f0-3c85-fe8e-ef71-5008daa03423@126.com>
Date: Sun, 21 Aug 2016 23:46:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.2.0
MIME-Version: 1.0
X-CM-TRANSID: C8mowAD3_y_qzLlXLae+Dg--.8552S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF18GF4rKw17trWxKF15Arb_yoW8Gw1xpa
	97J3ZY9r4vgrykJw1UJayDGFZ8Ar1fZFs7try5AwsF9ws5Aws7C34qka4YgayUZr4jqayF
	9w4aqFsxZw4rZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bYv38UUUUU=
X-Originating-IP: [171.212.168.219]
X-CM-SenderInfo: x22vjiat6rjloofrz/1tbiYA3MGVbdV92-8QAAs3
Subject: question about BBVERSIONS OVERRIDES and PREFERRED_VERSION
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
X-List-Received-Date: Sun, 21 Aug 2016 16:18:18 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

I'm using bare bitbake cloned from 'git://git.openembedded.org/bitbake'
Revision id is: 309f5907a3661821e041ed14645b5d165007b058

I has a tese.bb, the content is:

         OVERRIDES = ""
         PN = "test"
         PV = ""

         PREFERRED_VERSION_test = 'xxx'

         OVERRIDES .= "${@':' + ':'.join([x for x in 
'${BBVERSIONS}'.split()])}"
         BBVERSIONS = "develop 1.1.7"
         PREFERRED_VERSION_test = '1.1.7'


         NAME_1.1.7   = 'version is 1.1.7'
         NAME_develop = 'version is develop'


         python do_build() {
             bb.plain("==%s==" % d.getVar("NAME", True))
         }

Use 'bitbake test -e | less' to explore var setting.
I found:

	# $PV [3 operations]
	#   set /home/zzs/temp/bitbake-hello-world/main/../mylayer/test.bb:4
	#     ""
	#   set ast.py:401 [verfunc]
	#     "1.1.7"
	#   set ast.py:401 [verfunc]
	#     "develop"
	# pre-expansion value:
	#   "develop"
	PV="develop"

I'm already set PREFERRED_VERSION_test = '1.1.7' sure. Why the 'PV' is 
'develop'
And I try set BBVERSIONS = "develop 1.1.7 xx yy". Then 'PV' becomes 'yy'
So my first question is:

How can I select version '1.1.7' for test package through  BBVERSIONS 
and   PREFERRED_VERSION

The second question comes from the override of var 'NAME'.
In the output of 'bitbake test -e' can found:
	#
	# $NAME
	#   override[develop]:set 
/home/zzs/temp/bitbake-hello-world/main/../mylayer/test.bb:14
	#     "version is develop"
	NAME="version is develop"

I'm already set NAME_1.1.7 why bitbake just found override 'develop' but 
'1.1.7'











