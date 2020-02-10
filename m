Return-Path: <ross@burtonini.com>
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com
	[209.85.208.182])
	by mail.openembedded.org (Postfix) with ESMTP id 5D3BF60B34
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Feb 2020 15:57:17 +0000 (UTC)
Received: by mail-lj1-f182.google.com with SMTP id d10so7734254ljl.9
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Feb 2020 07:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=burtonini-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=ESicX03R7O88YZeoA49QkP9QEG0mlYacfoOxgY3JiTs=;
	b=TURbbp6gdi+3MPo6CM/PmpyzmY1p7j5KIap5VDE/B3+Q2LYZaS2vn7q9gGJ6AUC667
	E6n/CAtP+s0zHu6GLFZbCPBseUf/xzxzjosr71i+hjrO9sKxNOMONbWILv5SZMBRHCXa
	sYd3N4dRjjpgx5ZmbfBKV2XNQAcdsLEVDH7Mf/hWf9sSJ12V5/ZYGt++fF70jLGvgznz
	rXAH+5dubPHnQT6f4/SClKXrLKWFSR1Ps1vdukrWVQ44ADQ5HXxyZ/f81loF7AkRKSVu
	bjPsbUcDax9L5a/U5jr0ZF9POP19cPtR9LNeCzzeb9pUQ5jpfHk+j+cexcFpxpJgn3WY
	Vc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=ESicX03R7O88YZeoA49QkP9QEG0mlYacfoOxgY3JiTs=;
	b=UYvwLwtMhc1kiNnBh5ZJeWltd6YGh0j/Vbf0msjtx6gQDPLMIGUCOLwnNpOeJqpOXg
	QzXNpvsuPJezpHHhIjQgfe4qsMqwp5TTb6IlPVicaMwkHKNu/6aXXV2xJRRHkP1P+2PG
	J3WzXcRi/fsD2u3fQ4ZJjYeI1jVoqJvBJBQIiUBDdsbrfWqK05nWJ+i0ANUXv3HhHWix
	sxiBpZsn7Xa9ma9WPzSs66A4U2F2qUSRWo8A9J7RoaO9HMKYy3DrhJYi9UrtHniRHqqO
	q5lL8Dwzq+/nEBY0/tyNl+PAt4qq3N4NB73WRBMadRKnyUiXdFxLjmByavkZPemHzfI5
	9JcA==
X-Gm-Message-State: APjAAAUxOGEfHvM+NiQHfUer3qMJtGScredC/CrEftulj8nIienHU7s/
	4KmbFdVoJighTr7GusR/hT7wJnWk/0Uz6td8TrPUsg==
X-Google-Smtp-Source: APXvYqw3FI4qA+2Lm6fq0QaozLYMwwxsXp1lsMmFMFgo7YBKFAMW5DOADRNoK/bJNV6Progn0csj5AsDTndbjIgt0QI=
X-Received: by 2002:a2e:8e84:: with SMTP id z4mr1269422ljk.207.1581350238080; 
	Mon, 10 Feb 2020 07:57:18 -0800 (PST)
MIME-Version: 1.0
References: <CAOev9BfgUF4yCYYVwtLm1jQCKjwdTJPc5XHtPtrKq-vFzkdP_A@mail.gmail.com>
In-Reply-To: <CAOev9BfgUF4yCYYVwtLm1jQCKjwdTJPc5XHtPtrKq-vFzkdP_A@mail.gmail.com>
From: Ross Burton <ross@burtonini.com>
Date: Mon, 10 Feb 2020 15:57:04 +0000
Message-ID: <CAAnfSTs8CpqDMVv20EqQrSyFhY=n_J3Jkxd+1AG+tkenAhSvBA@mail.gmail.com>
To: =?UTF-8?Q?Mauro_Queir=C3=B3s?= <maurofrqueiros@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: git-lfs validation
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
X-List-Received-Date: Mon, 10 Feb 2020 15:57:18 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please do send a patch, or ideally two separate patches.

Ross

On Mon, 10 Feb 2020 at 14:14, Mauro Queir=C3=B3s <maurofrqueiros@gmail.com>=
 wrote:
>
> Hi,
>
>
>
> I noticed two things related to git-lfs on poky/bitbake/lib/bb/fetch2/git=
.py, which I think may me improved:
>
>
>
> First, git.py seems to always check the master branch when looking for lf=
s objects (_contains_lfs function), even when the branch is specified in SR=
C_URI;
>
>
>
> Second, the warning message "Repository %s has LFS content but it is not =
being fetched" is printed even when git-lfs is available and "lfs=3D1" is s=
et.
>
>
>
> I could also provide a patch if you think these two issues make sense.
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

