Return-Path: <rep.dot.nop@gmail.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
	[209.85.212.170])
	by mail.openembedded.org (Postfix) with ESMTP id 0E49473D17
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Apr 2015 19:42:49 +0000 (UTC)
Received: by widdi4 with SMTP id di4so72748703wid.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Apr 2015 12:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=user-agent:in-reply-to:references:mime-version
	:content-transfer-encoding:content-type:subject:from:date:to:cc
	:message-id; bh=wzgeHssFmTdeCSZ6CHJVb+BEjrm3Pd43fWdv+gKRS5o=;
	b=KFBces0G1hoQfJ7wIDRS3IdWDhLzpMIGD6dqBv27DLtZ2P1vi/1VkRmXIYhnlfaH3x
	3gtF4TgBZts0T9DLPlEoejzHG3z/1E6Hx2OIl6VKX9QP4pxsFsDsOFpRW5R+YKmbS8xp
	bOKAvQeRHOVnQQQXeQCxEt0hbfCkwp7P6Jz0jj2aebXuhA/hPRI/6FG87OAYYsKJ/DRI
	Kf9c34u4KoqmplNGD1NX17vRs/CXSc9tcIv1nti9idlTWX6O69KaaVHcpqwXfqNjlQMv
	ImyMZIugDNopLjgacUtkLA4AJyNMITL8JSHy44YfkSSVlG/T5WhObk4LjEPp5b6rAtba
	ExBg==
X-Received: by 10.194.192.104 with SMTP id hf8mr53408836wjc.44.1429126970562; 
	Wed, 15 Apr 2015 12:42:50 -0700 (PDT)
Received: from [10.52.110.26] (089144194026.atnat0003.highway.a1.net.
	[89.144.194.26])
	by mx.google.com with ESMTPSA id e2sm3417277wix.15.2015.04.15.12.42.48
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 15 Apr 2015 12:42:49 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <CABcZANkKhGMkjxWj1QcJDLtWZ+B3TKqR_JLSSw3nfze+Qet+3g@mail.gmail.com>
References: <1427827190-10442-1-git-send-email-Liam.Howlett@WindRiver.com>
	<CABcZANkKhGMkjxWj1QcJDLtWZ+B3TKqR_JLSSw3nfze+Qet+3g@mail.gmail.com>
MIME-Version: 1.0
From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Date: Wed, 15 Apr 2015 21:42:45 +0200
To: Christopher Larson <clarson@kergoth.com>,
	"Liam R. Howlett" <Liam.Howlett@windriver.com>
Message-ID: <BFA1A96F-292A-434A-8510-E19BE343A6B9@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2: Add BB_TRUSTED_NETWORK support
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
X-List-Received-Date: Wed, 15 Apr 2015 19:42:50 -0000
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8

On April 15, 2015 9:37:38 PM GMT+02:00, Christopher Larson <clarson@kergoth.com> wrote:
>On Tue, Mar 31, 2015 at 11:39 AM, Liam R. Howlett <
>Liam.Howlett@windriver.com> wrote:
>
>> This patch adds support for a new local.conf variable called
>> BB_TRUSTED_NETWORK.  BB_TRUSTED_NETWORK holds a list of hostnames
>that the
>> user
>> trusts as a source for downloading content.  If network access is
>enabled
>> and
>> the user has configured trusted hosts, then any hosts that are not in
>the
>> list
>> will cause an error to occur at fetch.  Any mirrors and pre-mirrors
>that
>> are
>> not in the list will result in warnings that these locations will not
>be
>> used.
>>
>> The BB_NO_NETWORK variable still stops all network access.
>>
>> Please see the comments in the patch for more details and example
>usage.
>>
>
>Hmm, looks like this might be useful with an internal mirror coupled
>with
>PREMIRRORS, so fetches from the internal host are allowed, but anything
>missing from there would be immediately caught?

That was my thought, too.
I would find BB_ALLOWED_NETWORKS more intuitive though.

Cheers,



