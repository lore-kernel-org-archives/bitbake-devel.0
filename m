Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
	[209.85.214.175])
	by mail.openembedded.org (Postfix) with ESMTP id 071547FF99
	for <bitbake-devel@openembedded.org>;
	Fri, 10 Jan 2020 22:39:13 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id bd4so1376033plb.8
	for <bitbake-devel@openembedded.org>;
	Fri, 10 Jan 2020 14:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:from:to:references:autocrypt:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=e8kfjDazr9oj8zsJgxbG3CQWDfahXuWiRIpsKb2Mlwk=;
	b=EQkfqnPC4LsQ7IVLl8Pn+NwO+PCWsEpkcemb4SsyRgMgPkDKQ2Wg0ICrcgkXWe5MHl
	U71DuJ1ABxZ4nrm5Vc7w4aSpZRCzsI3Vb/2XTSixDAbY59bPCi/zvotD7I8h+izeOQ9i
	eU7O3J5zO/mSXMNS3WZkLPCC53397/QhujVlVfOoBALXcVGeIa1mRzFGDKl8n4QqjMzv
	4XEQpS2wGH2eWyii0Ga1GvjRPvdvnqI2JNCIo2UMAnB7J2FsTB9ydQVupwadfXPAFgCx
	wsq4gH6SKh4iUcSgDkkYbNPWtxP9SiuPH2O7fIkcVKzINeqZal3ncQFOfT+Xb8Nk4YgI
	Sa7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:references:autocrypt:message-id
	:date:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=e8kfjDazr9oj8zsJgxbG3CQWDfahXuWiRIpsKb2Mlwk=;
	b=lGsASBCzLeoKLhrW//8j3hKym11n492zOQ09VU9CvFoVjU3JxsrOMXgaKlKev1d+ZD
	kbHTDNadgXTy18X/jvsI63Bt7U/9ulijFqu3+YYlmpVpRq/IA9smCBp7qrC5oyMOLSix
	OKYjVtkTw8VUUQXZLw2XNV+eW+gLsob2AUNkvo0+fk4mMDZPfkGV59mpaQFADIq3QDCu
	evzPzJFfSZhwL7wil/PYDty4HLsPmloFwIQazmsdBVzRzCy0wpWH4TgKre9FZHWCKhpQ
	TE4EH0o/3Np5THavS5GO2tTPhraGLM8h9IJ43SiqZ5OSjhzgH+udTL5DdhbJRbzyeTC0
	EdyA==
X-Gm-Message-State: APjAAAWsyOfGq7cHjy0RPygsRKhtyys3cUN8CGi2oaYodpVoIcgxo79M
	80MO+mXraKfnT8Ra8Ib2D+zT/M0E
X-Google-Smtp-Source: APXvYqwneAu01Sk2BH61e1DAulIfundKn/rznPFuVbH2Xx43unin8kSjvVWd2tfRM6ZqTUqZhfafnQ==
X-Received: by 2002:a17:90a:d143:: with SMTP id
	t3mr7663830pjw.106.1578695954735; 
	Fri, 10 Jan 2020 14:39:14 -0800 (PST)
Received: from ?IPv6:2601:202:4180:a5c0:3819:b940:29a4:50a6?
	([2601:202:4180:a5c0:3819:b940:29a4:50a6])
	by smtp.gmail.com with ESMTPSA id
	u127sm4325928pfc.95.2020.01.10.14.39.14
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
	Fri, 10 Jan 2020 14:39:14 -0800 (PST)
From: akuster808 <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
References: <cover.1578327474.git.akuster808@gmail.com>
Autocrypt: addr=akuster808@gmail.com; prefer-encrypt=mutual; keydata=
	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
	8CS2NxU=
Message-ID: <8956fac0-eea3-3a60-8fbd-90f17297415b@gmail.com>
Date: Fri, 10 Jan 2020 14:39:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
	Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <cover.1578327474.git.akuster808@gmail.com>
Subject: Re: [1.44 00/25] Pull request
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
X-List-Received-Date: Fri, 10 Jan 2020 22:39:14 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US

I understand there is a backlog of issues.

I will ping again next week.

- armin

On 1/6/20 8:26 AM, Armin Kuster wrote:
> Here is the next series for 1.44.
> Please merge to 1.44.
>
>
> The following changes since commit cfa307aabf710d79c404a8571b4158b864a94727:
>
>   runqueue.py: not show warning for deferred multiconfig task (2019-11-29 11:26:07 +0000)
>
> are available in the Git repository at:
>
>   git://git.openembedded.org/bitbake-contrib stable/1.44-next
>   http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.44-next
>
> Aníbal Limón (1):
>   lib/bb: Add BB_SIGNATURE_LOCAL_DIRS_EXCLUDE to speed-up taskhash on
>     directories
>
> Chris Laplante via bitbake-devel (1):
>   bb.utils.fileslocked: don't leak files if yield throws
>
> Joshua Watt (1):
>   runqueue: Batch scenequeue updates
>
> Ola x Nilsson (1):
>   prserv/serv: Use with while reading pidfile
>
> Richard Purdie (21):
>   hashserv: Add support for equivalent hash reporting
>   runqueue/siggen: Allow handling of equivalent hashes
>   runqueue: Add extra debugging when locked sigs mismatches occur
>   knotty/uihelper: Switch from pids to tids for Task event management
>   siggen: Avoid taskhash mismatch errors for nostamp tasks when
>     dependencies rehash
>   siggen: Ensure new unihash propagates through the system
>   siggen: Fix performance issue in get_unihash
>   runqueue: Rework process_possible_migrations() to improve performance
>   runqueue: Fix task mismatch failures from incorrect logic
>   siggen: Split get_tashhash for performance
>   runqueue: Fix sstate task iteration performance
>   runqueue: Optimise task migration code slightly
>   runqueue: Optimise out pointless loop iteration
>   runqueue: Optimise task filtering
>   runqueue: Only call into the migrations function if migrations active
>   lib/bb: Optimise out debug messages from cooker
>   runqueue: Fix equiv hash handling build failures
>   runqueue: Ensure task dependencies are run correctly
>   runqueue: Fix task dependency corner case in sanity test
>   siggen: Test extra cross/native hashserv method
>   cache: Lower debug level for wold build messages
>
>  lib/bb/__init__.py        |   5 ++
>  lib/bb/build.py           |  25 +++----
>  lib/bb/cache.py           |   6 +-
>  lib/bb/checksum.py        |   5 +-
>  lib/bb/fetch2/__init__.py |   4 +-
>  lib/bb/runqueue.py        | 137 +++++++++++++++++++++++---------------
>  lib/bb/siggen.py          | 104 +++++++++++++++++++++++------
>  lib/bb/ui/knotty.py       |  12 ++--
>  lib/bb/ui/uihelper.py     |  39 ++++++-----
>  lib/bb/utils.py           |   9 +--
>  lib/hashserv/client.py    |   8 +++
>  lib/hashserv/server.py    |  36 ++++++++++
>  lib/prserv/serv.py        |  12 ++--
>  13 files changed, 277 insertions(+), 125 deletions(-)
>


