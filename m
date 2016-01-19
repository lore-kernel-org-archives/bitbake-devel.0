Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 1E71473174
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Jan 2016 17:48:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0JHmY7K001874; Tue, 19 Jan 2016 17:48:34 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id CBHYhNLpjgRF; Tue, 19 Jan 2016 17:48:34 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0JHmTZE001870
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 19 Jan 2016 17:48:32 GMT
Message-ID: <1453225709.27999.132.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Olof Johansson <olof.johansson@axis.com>,
	bitbake-devel@lists.openembedded.org
Date: Tue, 19 Jan 2016 17:48:29 +0000
In-Reply-To: <1453215851-19422-1-git-send-email-olof.johansson@axis.com>
References: <1453215851-19422-1-git-send-email-olof.johansson@axis.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [PATCH] tests/codeparser.py: Add filename/lineno flags to test variable
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
X-List-Received-Date: Tue, 19 Jan 2016 17:48:37 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2016-01-19 at 16:04 +0100, Olof Johansson wrote:
> A recent change in bitbake added filename/lineno information to the
> parameters of bb.data.build_dependencies(). The codeparser tests
> required a little adaption to the changes, adding the flags to the
> FOO
> variable used in the tests.
> 
> The error seen when running the tests is a TypeError exception raised
> in bb.codeparser:
> 
>   TypeError: int() argument must be a string or a number, not
> 'NoneType'

Thanks. I'm asking awkward questions about why we didn't find that
sooner too (if I didn't spot it, our QA infrastructure should have)...

Cheers,

Richard

