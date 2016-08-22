Return-Path: <zzs213@126.com>
Received: from m15-113.126.com (m15-113.126.com [220.181.15.113])
	by mail.openembedded.org (Postfix) with ESMTP id CF1CF731DA
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Aug 2016 06:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=zwMu0
	KtcT/ZfSVLWBYdem851dZWfhb9g9P46naNQNR8=; b=KS1yLQu0CFYzBUbHh74bG
	wuNheAIigAQbLq4Hj2PH3nKreIyJ1ZyeF6nAM+OGFCRvsTqYkRuaZ9+buMTtU/Ok
	Btb/yNRCE7ceTNTtTVzbnZRFGne41HpOGf08TYFt7guVLX49MJeavZrUhxyzUX9W
	rAR0hil1mXGjj6w2kpeMXE=
Received: from [192.168.0.12] (unknown [171.212.168.219])
	by smtp3 (Coremail) with SMTP id DcmowACnbR7TobpXAWCHEQ--.51175S2;
	Mon, 22 Aug 2016 14:55:17 +0800 (CST)
To: bitbake-devel@lists.openembedded.org
References: <0c2145f0-3c85-fe8e-ef71-5008daa03423@126.com>
From: =?UTF-8?B?5byg5b+g5bGx?= <zzs213@126.com>
Message-ID: <754ba7e8-128f-cd67-7f1c-d3e2a57b006c@126.com>
Date: Mon, 22 Aug 2016 14:55:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <0c2145f0-3c85-fe8e-ef71-5008daa03423@126.com>
X-CM-TRANSID: DcmowACnbR7TobpXAWCHEQ--.51175S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw4fXr1fXFW8Gr1DKFW3ZFb_yoW8GF18pa
	yxG3Z5Cr1IgF1fCr18J3ykKrn0y3yxZF1xt3y3Jw4q9wsayws7C3s0kr1Yka4DAr4Fqa1F
	9F1fuFs8CFs7WaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jZ3ktUUUUU=
X-Originating-IP: [171.212.168.219]
X-CM-SenderInfo: x22vjiat6rjloofrz/1tbi2wTNGVR0dor1eQAAsb
Subject: Re: question about BBVERSIONS OVERRIDES and PREFERRED_VERSION
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
X-List-Received-Date: Mon, 22 Aug 2016 06:55:21 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

I answer my first question

The reseaon is that PREFERRED_VERSION_xxx must in a conf file which 
should put data to global area.

So I edit my bitbake.conf. Now it is:

BB_SIGNATURE_HANDLER = "basichash"

TMPDIR  = "${TOPDIR}/tmp"
CACHE   = "${TMPDIR}/cache"
STAMP   = "${TMPDIR}/stamps"
T       = "${TMPDIR}/work"
B       = "${TMPDIR}"

PREFERRED_VERSION_test = '1.1.7'


And my test.bb Now is:

OVERRIDES = ""
PN = "test"
PV = ""

OVERRIDES .= "${@'test:' + ':'.join([x for x in '${BBVERSIONS}'.split()])}"
BBVERSIONS = "develop 1.1.7 pp"


NAME_1.1.7   = 'version is 1.1.7'
NAME_develop = 'version is develop'
NAME_pp = 'version is pp'


python do_build() {
     bb.plain("==%s==" % d.getVar('NAME', True))
}

Use 'bitbake test -e' to examine the overrides of var 'NAME', It is 
still not contain override for '1.1.7':

#
# $NAME [2 operations]
#   override[develop]:set 
/home/zzs/temp/bitbake-hello-world/main/../mylayer/test.bb:10
#     "version is develop"
#   override[pp]:set 
/home/zzs/temp/bitbake-hello-world/main/../mylayer/test.bb:11
#     "version is pp"
# pre-expansion value:
#   "version is pp"
NAME="version is pp"

Why ? I expect it should contain override for '1.1.7', like this:
          override[1.1.7]:set 
/home/zzs/temp/bitbake-hello-world/main/../mylayer/test.bb:11
          ....
And I found all NAME_xxx, where xxx is [a-z] all OK? I has no idea about 
this.
Anybody help me?


