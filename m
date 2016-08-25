Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id CADC7607A4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Aug 2016 11:51:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7PBoXAt028532; Thu, 25 Aug 2016 12:50:33 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 7X16EsD-cnvu; Thu, 25 Aug 2016 12:50:33 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7PBoVl1028529
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 25 Aug 2016 12:50:33 +0100
Message-ID: <1472125831.16712.144.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: =?UTF-8?Q?=E5=BC=A0=E5=BF=A0=E5=B1=B1?= <zzs213@126.com>,
	bitbake-devel@lists.openembedded.org
Date: Thu, 25 Aug 2016 12:50:31 +0100
In-Reply-To: <d14aa6a9-7e47-55ff-aa24-d9e3892fa677@126.com>
References: <0c2145f0-3c85-fe8e-ef71-5008daa03423@126.com>
	<754ba7e8-128f-cd67-7f1c-d3e2a57b006c@126.com>
	<d14aa6a9-7e47-55ff-aa24-d9e3892fa677@126.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
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
X-List-Received-Date: Thu, 25 Aug 2016 11:51:25 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2016-08-22 at 17:56 +0800, 张忠山 wrote:
> But, I'm not sure this work for other env.
> 
> I don't know why just lower case override permited in  this function.
> 
> Version string just include digit and point is very common, but 
> islower() return False for these strings.
> 
> This behavior is intended or a bug?
> Or has another way to solve my problem?

There was a discussion a while ago and we decided to only have bitbake
accept lower case overrides. I believe that the numeric piece isn't an
issue but the decimal point character probably is.

The reason for this was to try and avoid some of the performance costs
where any variable with a "_" in the name was potentially an override
character and this was costly for variable processing.

Cheers,

Richard


