Received: from mail-lpp01m010-f47.google.com ([209.85.215.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1TDm9Y-0005qZ-8k
	for bitbake-devel@lists.openembedded.org;
	Tue, 18 Sep 2012 02:59:04 +0200
Received: by lagv3 with SMTP id v3so4279085lag.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Sep 2012 17:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=59eflNVCOX9kTV87bJret7SrROQ3/C9xDIF6O4seZKk=;
	b=G27moQQPS3L2VBfvrrIH68PionxQXcp4KqQl/wiOT5eYtOwGRcWWn0NZe/AR7smlzf
	jZPkfIGcg3iQEAopwBC6txvpj2ii6z5Yjg/ZZ7izEmrPercU4hR87zrfJq1xfRcEGy5w
	rWfCSxROuRDGZ0j/1HV3HbgM6NP483sG6QBSij5/2CyHq/XMjhhrB7Ot+/94C7pGrXls
	MwaNeux7KvsoZ65ZwLyqoyr5Wk4OyE83lI8cOKBQkV5MhDXn/Zl9Opqa8oLdiwhJgli1
	sq3gqS/xFY+8uKOq5ESbY1iYq/slZR794IlvHT7KPad/AWgsAMYjHx6WvLM8GWngK9ag
	NcIQ==
Received: by 10.112.87.164 with SMTP id az4mr4444692lbb.73.1347929184831; Mon,
	17 Sep 2012 17:46:24 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.114.19.2 with HTTP; Mon, 17 Sep 2012 17:46:04 -0700 (PDT)
In-Reply-To: <1347921818-60562-2-git-send-email-jason.wessel@windriver.com>
References: <1347921818-60562-1-git-send-email-jason.wessel@windriver.com>
	<1347921818-60562-2-git-send-email-jason.wessel@windriver.com>
From: Chris Larson <clarson@kergoth.com>
Date: Mon, 17 Sep 2012 17:46:04 -0700
X-Google-Sender-Auth: 5dr1diMHdWQD41KUdjo1o37Pcts
Message-ID: <CABcZANkRiYXarfHjqF9u2tuqyqJZtqDuom3Ueta4AwYxENP_Sg@mail.gmail.com>
To: Jason Wessel <jason.wessel@windriver.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/8] bitbake: Unbuffer stdout for log files
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 18 Sep 2012 00:59:04 -0000
Content-Type: text/plain; charset=UTF-8

On Mon, Sep 17, 2012 at 3:43 PM, Jason Wessel
<jason.wessel@windriver.com> wrote:
> It is possible to lose critical log data when python exits in an
> unorderly fashion via segmentation fault or certain types of crashes.
> This is because the buffer characteristics are inherited from the top
> level stdout, which should be set to unbuffered, for the purpose of
> all the forked children.
>
> This pushes the buffering to the OS, instead of having python managing
> the buffers in its stream handler class.
>
> This change is also to provide the ability to tail logs written from
> processes in "real time" because they would be written in an orderly
> fashion depending upon the OS characteristics for the file I/O.
>
> (LOCAL REV ONLY: NOT UPSTREAM)
>
> Signed-off-by: Jason Wessel <jason.wessel@windriver.com>


I'm assuming you forgot to rebase -i and remove the LOCAL REV ONLY? :)
-- 
Christopher Larson


