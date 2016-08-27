Return-Path: <zzs213@126.com>
Received: from m15-114.126.com (m15-114.126.com [220.181.15.114])
	by mail.openembedded.org (Postfix) with ESMTP id 5C2AB6FF9F
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 27 Aug 2016 07:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=oSWoP
	iGL9eRr+tLtoa1dqE8gQo8NYJzD7dKDFgTrkzU=; b=oGSf0BomS/+7hb7rle4CM
	Wbd0zMjHHn82UFPFQ0B02O/mA8Yn8Iqkt0/DBJyNr6u4j6wy435inqWtfDqwftBZ
	6xYVDkLKmgxjL4/phqtZF7pWt2gysMp95NIkJwXFN6KhnvKD6XZyhVf2zXv+/LJc
	yShn7LGNF2dAGSpOJyHkag=
Received: from [192.168.0.12] (unknown [171.212.170.252])
	by smtp7 (Coremail) with SMTP id DsmowAB3DbYgQsFX68TQEg--.18730S2;
	Sat, 27 Aug 2016 15:32:49 +0800 (CST)
References: <1472189699-6646-1-git-send-email-zzs213@126.com>
	<CAMKF1soRMSf9EvC5RMuVuJbyA4dRC=n+B9nSjCXovD_F_zvTwQ@mail.gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
From: =?UTF-8?B?5byg5b+g5bGx?= <zzs213@126.com>
Message-ID: <77d61119-5b4f-d897-fa94-4490098219bc@126.com>
Date: Sat, 27 Aug 2016 15:32:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAMKF1soRMSf9EvC5RMuVuJbyA4dRC=n+B9nSjCXovD_F_zvTwQ@mail.gmail.com>
X-CM-TRANSID: DsmowAB3DbYgQsFX68TQEg--.18730S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFyfJry5GF4fXrWkGrykZrb_yoWkJwb_WF
	40vryktFs8Jr4xta13tan8A3srK3W5uFW0q3yfKw1Ska47G3WagrZrXrykZw17WryjkFsI
	kFyavry7tr92kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU57R67UUUUU==
X-Originating-IP: [171.212.170.252]
X-CM-SenderInfo: x22vjiat6rjloofrz/1tbiLQLSGVc1o2OowAAAsu
Subject: Re: [PATCH] enable override for suffix just include digit and dot
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
X-List-Received-Date: Sat, 27 Aug 2016 07:32:55 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> Without this patch, if we write these in recipe test.bb <http://test.bb>:
>>
>>         NAME_1.1.7   = 'version is 1.1.7'
>>         NAME_develop = 'version is develop'
>>
>> Use 'bitbake test -e' to observe 'NAME':
>>         #
>>         # $NAME [2 operations]
>>         #   override[develop]:set .../test.bb:10 <http://test.bb:10>
>>         #     "version is develop"
>>         # pre-expansion value:
>>         #   "version is develop"
>>         NAME="version is develop"
>>
>> Obviously, override for '1.1.7' missing.
>
> Dot is not allowed in variable names intentionally since its file
> extension separator. I am not sure if its a good idea to allow it in
> variable names

Since we can use the path delimeter '/' in override like 
'virtual/kernel'. Why we can't use dot in override.

And bitbkae would add 'PV'(which default to '1.0' in OE) to 'OVERRIDES'. 
So using dot in override may not be an issue.

In bitbake manual, It said we can use BBVERSIONS and override to let 
sigle recipe support multiple package version

If we can't use dot in override, Howto use BBVERSIONS? Use embedded 
python code to set var according version? But it is ugly tahn using 
override!



