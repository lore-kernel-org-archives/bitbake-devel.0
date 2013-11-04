Return-Path: <nicolas.dechesne@linaro.org>
Received: from mail-ob0-f169.google.com (mail-ob0-f169.google.com
	[209.85.214.169])
	by mail.openembedded.org (Postfix) with ESMTP id 601C16D3CC
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  4 Nov 2013 18:48:42 +0000 (UTC)
Received: by mail-ob0-f169.google.com with SMTP id uz6so7561426obc.14
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 04 Nov 2013 10:48:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=7XbhKdn6B2AYZWQqvFPDZ+eyMYQLyXUdJGXTiUCaaHo=;
	b=JxmqX7ZcJm+gTq7+PJZFmaZgGmd0Np2urNwRCN2sI0vbofE02F1BGhKpLe3c/q7zlJ
	A5cYmjfs6k/i4tXzN2h8YJjylnmtJjy587lNhIK8ZvEks0Gqcw1d1HirQIV+Ye4vpSG9
	HvldghVc+Qj8xzWBUTBzkYBkI3uQCUiBdVzhxuKGGj4631xzgpY39yFCkHiDld6bvrxz
	33OR4vnYwrMnCHZzkZc9joopjT7XMO+P34hfD1fmKgp3UKaB9qPhxrvowplnzwe+TwZu
	dMwzDXeMBgHXPCA1ns4pC9etMrsWBqWKGgJuqi0mWfE9f3XJ//57VFX5gqcDwCLabWrh
	k/5w==
X-Gm-Message-State: ALoCoQkAmKQuiC+gMrBS4iFlX/vXaH1C0YjU3MldEwodWPebC5Gfa6Qwl+U2gVBhjtU4dy0D8ugD
X-Received: by 10.182.44.167 with SMTP id f7mr15377726obm.3.1383590924118;
	Mon, 04 Nov 2013 10:48:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.76.156.40 with HTTP; Mon, 4 Nov 2013 10:48:24 -0800 (PST)
In-Reply-To: <1383266185-2917-1-git-send-email-nicolas.dechesne@linaro.org>
References: <1383266185-2917-1-git-send-email-nicolas.dechesne@linaro.org>
From: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Date: Mon, 4 Nov 2013 10:48:24 -0800
Message-ID: <CAP71Wjz8DXdFYqMER6uy+7X9ic-PJmGQVp+d5ayC4TJ5Eqgozw@mail.gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Cc: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: Re: [PATCH RFC] fetch2/svn.py: use log instead of info to retrieve revision
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
X-List-Received-Date: Mon, 04 Nov 2013 18:48:43 -0000
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Oct 31, 2013 at 5:36 PM, Nicolas Dechesne
<nicolas.dechesne@linaro.org> wrote:
> We have faced a corner case situation where the 'last changed
> revision' returned from svn info is wrong. It happens when the last
> revision is a directory move. e.g. if we assume that the svn
> repository at revA has root/x/y/z/foo/bar and it is moved to
> root/a/b/c/foo/bar in revB, then svn info 'last change revision' will
> return revA. As such when using AUTOREV, we are going to attempt to
> retrieve root/a/b/c/foo/bar (as per SRC_URI) but at revA when it did
> not exist.
>
> So this patch changes how we retrieve the latest revision and uses
> 'svn log --limit 1' which gives correct result in all tested cases.

Richard, thanks for merging in master. any chance this can go to dora
and dylan too, as this is a bug fix? the same patch applies in both
branches, and we are currently using dylan and dora for our projects.

thanks

