Return-Path: <zzs213@126.com>
Received: from m15-113.126.com (m15-113.126.com [220.181.15.113])
	by mail.openembedded.org (Postfix) with ESMTP id 9F817605BA
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Dec 2016 07:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Message-ID:Date:MIME-Version; bh=nnoZY
	BxjhxkqirXWaCXSdc4lnsqefHCOtRL8qFB2J+w=; b=gujV7hKs7UoHKJcTzid5F
	Y/3ewL2ET8Nj/jCBV7RD2TxYvg7Yhseotxo4Wa2Qeg5PppT5IMcxHN98VgtsViqG
	TdJFKkoneV3G0jpofJQsGTVNIk6q8kc5mkdMzAU5a3PnaPSOhwuE6QEXgO9atWVo
	3M65PpCL0TIh7HI2sKsXpE=
Received: from [192.168.0.12] (unknown [171.212.171.33])
	by smtp3 (Coremail) with SMTP id DcmowAD3_7+hvmBYT5XgBw--.60153S2;
	Mon, 26 Dec 2016 14:54:27 +0800 (CST)
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
From: =?UTF-8?B?5byg5b+g5bGx?= <zzs213@126.com>
Message-ID: <599fe1d4-efa2-c129-a78a-716861df80bb@126.com>
Date: Mon, 26 Dec 2016 14:54:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.5.1
MIME-Version: 1.0
X-CM-TRANSID: DcmowAD3_7+hvmBYT5XgBw--.60153S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUkQ6pDUUUU
X-Originating-IP: [171.212.171.33]
X-CM-SenderInfo: x22vjiat6rjloofrz/1tbiZgNMGVUJX6jv9wAAsD
Subject: howto debug a task
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
X-List-Received-Date: Mon, 26 Dec 2016 07:25:49 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello everybody:

I'm using bitbake to build my embedded system. When I try to debug a task
using winpdb. I can't trace bitbake's server side.
For example, I try to see the back of do_fetch using:

	winpdb $(which bitbake) -c fetch busybox

But winpdb go, But can't set break point on bitbake's server code.

Who can told me How to trace bitbake's server code, and use what
tools?


