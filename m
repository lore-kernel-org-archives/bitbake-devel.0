Return-Path: <zzs213@126.com>
Received: from m15-113.126.com (m15-113.126.com [220.181.15.113])
	by mail.openembedded.org (Postfix) with ESMTP id 40D6B771DF
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  9 Aug 2016 07:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Message-ID:Date:MIME-Version; bh=yLycm
	eOtIDHFKC6SHTEfFYKQuUv5JTexzR4S13Vw4z4=; b=kLKnmRFsRSKEndpqZInMn
	DhvdjI/F5Xc8u+KJgmwBpZ9MTIPXpUA9zalOOE0S0Wt4in9cE7qve4RHTvp+U+eO
	dxhsGVNPqUQkDfseqkLwzmTUiRbYNk15axy8lqfV6xfG70/nsGpxivuzaHQNRG6W
	UCJQoNgUrtN1hnTQszthR8=
Received: from [192.168.0.12] (unknown [171.212.168.165])
	by smtp3 (Coremail) with SMTP id DcmowACHg7miiKlXo0O_Dg--.11469S2;
	Tue, 09 Aug 2016 15:39:16 +0800 (CST)
To: bitbake-devel@lists.openembedded.org
From: =?UTF-8?B?5byg5b+g5bGx?= <zzs213@126.com>
Message-ID: <dec52a2f-ef2f-f9c1-9ca2-e8b99cea7694@126.com>
Date: Tue, 9 Aug 2016 15:39:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.2.0
MIME-Version: 1.0
X-CM-TRANSID: DcmowACHg7miiKlXo0O_Dg--.11469S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUkQzVUUUUU
X-Originating-IP: [171.212.168.165]
X-CM-SenderInfo: x22vjiat6rjloofrz/1tbiLQTAGVc1osHBpAAAsU
Subject: howto rerun a task whenever it's content chang
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
X-List-Received-Date: Tue, 09 Aug 2016 07:39:24 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

I have a task in test.bb. say do_task1

run 'bitbake test -c task1'. then generate stamp file for it.

Now I found a bug and edit do_task1. but run 'bitbake test -c task1' 
again, Bitbake said

	'Attempted 1 tasks of which 1 didn't need to be rerun and all succeeded'

I remove the stamp file, then the task rerun ok.

It's so strange! The meta data changed, Why the task refuse to rerun?

It should rerun automaticaly.

Any one told me howto let the task auto rerun whenenver it's content 
changed!


