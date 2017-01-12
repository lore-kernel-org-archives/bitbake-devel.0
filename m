Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 4829371C92
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jan 2017 21:19:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v0CLGFSK028780; Thu, 12 Jan 2017 21:17:01 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id fL_zmcNyttyQ; Thu, 12 Jan 2017 21:17:01 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v0CLGu82028814
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 12 Jan 2017 21:16:57 GMT
Message-ID: <1484255816.4367.236.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Date: Thu, 12 Jan 2017 21:16:56 +0000
In-Reply-To: <2A86F721-051E-4344-AC93-362DB2E4EF56@linux.intel.com>
References: <1482352057-26139-1-git-send-email-jianxun.zhang@linux.intel.com>
	<1482397158.9843.130.camel@linuxfoundation.org>
	<48AEE85D-1072-4C81-922D-D9DF9A3E4D66@linux.intel.com>
	<DA1C4B84-D5CA-4BE4-97D3-CA19F1E89C2F@linux.intel.com>
	<1484242870.4367.219.camel@linuxfoundation.org>
	<2A86F721-051E-4344-AC93-362DB2E4EF56@linux.intel.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] use multiple processes to dump signatures.
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
X-List-Received-Date: Thu, 12 Jan 2017 21:19:09 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2017-01-12 at 11:33 -0800, Jianxun Zhang wrote:
> I appreciate your multiple hints on the road for this issue! I do
> _feel_ this patch needs some improvement or tests, but I cannot
> identify them in my sight. Well, things shouldn’t be such easy with a
> V1 due to the complexity.

I think your testing was fine, I just wanted to double check a few
things with the patch which I've now done and things seem fine.

> That’s why I have to hand over the burden to you. :-) Feel free to
> let me know any new possibilities.
> 
> I am actually interested in the data you shared. I improved my sig-
> dumping over 10 times (14.4 sec to 1 sec). Your test should covers
> other steps, so the improvement on sig dumping is less significant,
> 325.08 to 93.93 sec.
> 
> Maybe we should find some time to investigate any room to speed up
> the rest in test suite...

I knew that improvement would help this set of tests significantly and
230s or ~4 minutes is a good saving to have per test. oe-selftest
currently takes up to around 8 hours and if we can knock 4 minutes off
say 10 tests that is a good saving! :)

I very much agree that we need to look at other ways of speeding up oe-
selftest. I actually found another problem Ross sent a patch for
earlier today which improve the test load time significantly and should
take another ~10mins off the 8 hours and makes running this manually
less annoying. We also have plans to use memory resident bitbake to
help. There are lots of places in oe-selftest it runs "bitbake -e XXX"
to get variables an the time taken to do this mounts up quickly. If
bitbake is memory resident, we should be able to get answers much
faster.

There is also the option of parallelising oe-selftest too, currently
the tests run in series but running in parallel would help too.

So plenty more work to do but this is a good start (and there are
several other use cases for this codepath I'm happy to see speeded up
too!).

Cheers,

Richard



