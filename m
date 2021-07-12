Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
 by mx.groups.io with SMTP id smtpd.web09.8769.1626083545821357953
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Jul 2021 02:52:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=dwrobel@ertelnet.rybnik.pl header.s=ertelnet header.b=UD9xyOgI;
 spf=pass (domain: ertelnet.rybnik.pl, ip: 136.143.188.14, mailfrom: dwrobel@ertelnet.rybnik.pl)
ARC-Seal: i=1; a=rsa-sha256; t=1626083541; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Xhn/jt6lvWCHu/lbUbF3kv5uhSlqxx2OuttQCQViEkb2nMKkNDJ5AD8gmIR71a/IeG7sqqDPF5n/9DgkSj3kLI10zqdLmbZQVOsU+30pG6G0H+QJXJ4KSVtEEiE8tcZRi16C2kkizTXUdpvxHOp2GbKLu93bSptMMiYTe9XjtYg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1626083541; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=YNoytMkx6/WDBfk63i2NrvCoDnsdSRcoqS4aTunBckA=; 
	b=m9QsVtf1uZ2AabT31k+m2LjZRWT709CS0aWSm+kSXx5UoxAMY8pzvZswNcURzsIYQZF571B4+FXEnSg8nhJX0U+bEMSJdKacYhKUczVUTzPJrKaX1ZwspV095OxRkq16Kogd+08H9MAfpEXBUcqQEMHAf0SW4vv9E99jt02g6Lo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ertelnet.rybnik.pl;
	spf=pass  smtp.mailfrom=dwrobel@ertelnet.rybnik.pl;
	dmarc=pass header.from=<dwrobel@ertelnet.rybnik.pl>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1626083541;
	s=ertelnet; d=ertelnet.rybnik.pl; i=dwrobel@ertelnet.rybnik.pl;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YNoytMkx6/WDBfk63i2NrvCoDnsdSRcoqS4aTunBckA=;
	b=UD9xyOgICpotP2JvDh/ebFr+1guKsQvlVW+/33g8U1mrfsErTlMSQMENEeDOsRWT
	TzVg4ALz/4wZlHjXfvDzugbJ2C6eefVqkTUlGgGLg4igUt3LYuJPdu69lW/YArgkTgM
	/ojpzhzXumgd+p7b2UWgZOtYcTogPBF/DKL3KAqI=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1626083539104212.40142217339167; Mon, 12 Jul 2021 02:52:19 -0700 (PDT)
Date: Mon, 12 Jul 2021 11:52:19 +0200
From: "Damian Wrobel" <dwrobel@ertelnet.rybnik.pl>
To: "Richard Purdie" <richard.purdie@linuxfoundation.org>
Cc: "bitbake-devel" <bitbake-devel@lists.openembedded.org>,
	"Adam Romanek" <romanek.adam@gmail.com>
Message-ID: <17a9a21b88c.123cea52b312847.7778360805238815749@ertelnet.rybnik.pl>
In-Reply-To: <3cb191b83c3a9223ad76dff397d6d3c0dd8b755a.camel@linuxfoundation.org>
References: <20210708123021.568443-1-dwrobel@ertelnet.rybnik.pl> <3cb191b83c3a9223ad76dff397d6d3c0dd8b755a.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2/s3: improve checking if object exists in s3 by using botocore
MIME-Version: 1.0
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit




 ---- On Sun, 11 Jul 2021 11:47:58 +0200 Richard Purdie <richard.purdie@linuxfoundation.org> wrote ----
 > On Thu, 2021-07-08 at 14:30 +0200, Damian Wrobel wrote:
 > > From: Adam Romanek <romanek.adam@gmail.com>
 > > 
 > > Botocore uses urllib3 which in turn uses a connection pool to issue HTTP
 > > requests. Keeping the S3 client obtained from botocore library allows
 > > one to reuse that connection pool.
 > > 
 > > The S3 client obtained from botocore is now kept in a connection
 > > cache, which in case of sstate-cache checks is set up in
 > > openembedded-core/classes/sstate.bbclass.
 > > 
 > > On Python 3.5+ a ResourceWarning on unclosed SSL socket is issued when
 > > dropping the reference to botocore S3 client, which is a known issue but
 > > apparently a false positive: https://github.com/boto/boto3/issues/454
 > > 
 > > Initial results show the time to check ~2700 objects is cut by 85%
 > > (4 mins -> 35 secs).
 > > 
 > > With this change setting SSTATE_MIRRORS directly to S3 could now be the
 > > preferred method for using sstate-cache from S3 (no need to sync
 > > sstate-cache from S3 prior running the build), especially when the cache
 > > grows significantly over time (e.g. from 4GB to 30GB during the day).
 > > 
 > > Signed-off-by: Adam Romanek <romanek.adam@gmail.com>
 > > Signed-off-by: Damian Wrobel <dwrobel@ertelnet.rybnik.pl>
 > 
 > With this change all the builds on the autobuilder and my local builds 
 > start showing:
 > 
 > WARNING: S3 FetchMethod: consider installing botocore to speed up S3 access
 > 
 > which isn't really appropriate for users not using S3.

If you're not using s3:// scheme and you see this warning then perhaps we should
answer the question whether the s3 fetcher needs to be instantiated unconditionally?
If not (which would be the preferred solution), then it should be fixed/improved in the common
bitbake code.

FYI, we're using s3 extensively and our additional observation is that s3 fetcher is being
instantiated three times, which might suggest that something is suboptimal in the bitbake.

 > 
 > I'm also a little worried that the changes in this patch appear to effectively
 > totally change the fetcher type to effectively different code, I'm torn on that

Saying "totally" is a strong statement, while from the implementation point of view
it just implements a single function checkstatus() in a different (a little bit faster) way.

--
Regards,
Damian

 > and whether it is nearly a different fetcher type.
 > 
 > Cheers,
 > 
 > Richard
 > 
 > 
