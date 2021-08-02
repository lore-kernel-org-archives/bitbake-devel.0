Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web08.22009.1627919586188111006
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Aug 2021 08:53:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fhXWIdzR;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id j2so21974673wrx.9
        for <bitbake-devel@lists.openembedded.org>; Mon, 02 Aug 2021 08:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=S4CGGL7iikBO8XxW3Aw4KglfW4i7VOkaqoAtaegk2/Y=;
        b=fhXWIdzRGd7DPnKzDAvTrWwJRa6+Dv4Dt4kaVxoT6HQycJ13yyJEZLYwK0TOF3g9kv
         8J8+pa9GO+YtthVrQ1IZjHaRH/+f/EKvjZlvlXbQAd8te0zambcH8N5CT6V2JjD3tKTT
         UOsgZhWLx/0F7Ql0aPB7HrhvLwefGO1BH1Rv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=S4CGGL7iikBO8XxW3Aw4KglfW4i7VOkaqoAtaegk2/Y=;
        b=PKFU4HugmjOb53ZxJP/rasBTbrOq1aiqtL3JZNOyt7rA7wxp9IyCUeBIZqLTwXf80M
         FGf6M7St5EOX2EAetcMEApOw4WfDHcoWjNwzgLT3b06np99gr+VwscMOOOYTzjyj6x4z
         Mrhp2bWt+jfxcRMQNqjVcUpU+mOkk3Crwv45RSM4Oal1AEBWk6H7zB9czPDmPbdqJ8Fg
         iSyzqmOoZhpb+PVa26c0eYPuH8qs5+YYK/k4syOizypVCFjChum80vLCG6Itx2ytLFqz
         Kem5Odt2smGDCTYJ+U8vlGDZWVWIwBo/A2u1LbWISBdUQVHamABNbK58pXpTNTcg7Cnr
         5Nyw==
X-Gm-Message-State: AOAM533taJ+PUSP1EW+lWoPOuLiPB4QVdwPMZFha5gkja8BL9gO0f+fO
	2BrPE5zoTxX7tOd6HF6j/zPiOw==
X-Google-Smtp-Source: ABdhPJzYxMBklforxDTfpNlscsrhkwC1CulmoPfSrSy1pJla+XkLvQaXzsHebpdf3wSmVTZYfCyMTA==
X-Received: by 2002:a5d:6912:: with SMTP id t18mr10330868wru.234.1627919584642;
        Mon, 02 Aug 2021 08:53:04 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:9aac:cd42:2ef7:1a7c? ([2001:8b0:aba:5f3c:9aac:cd42:2ef7:1a7c])
        by smtp.gmail.com with ESMTPSA id b14sm11877086wrm.43.2021.08.02.08.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 08:53:04 -0700 (PDT)
Message-ID: <2ad1b01f7147de6149cc581963af1379a7984124.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] data_smart: Fix inactive overide accidental variable value corruption
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Konrad Weihmann <kweihmann@outlook.com>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 02 Aug 2021 16:53:03 +0100
In-Reply-To: <AM9PR09MB46429863371012A2E7080F37A8EF9@AM9PR09MB4642.eurprd09.prod.outlook.com>
References: <20210802154212.3453639-1-richard.purdie@linuxfoundation.org>
	 <AM9PR09MB46429863371012A2E7080F37A8EF9@AM9PR09MB4642.eurprd09.prod.outlook.com>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2021-08-02 at 17:46 +0200, Konrad Weihmann wrote:
> 
> On 02.08.21 17:42, Richard Purdie wrote:
> > Setting something like:
> > 
> >    BAR:append:unusedoverride
> > 
> > should cause BAR to be None, not "" which was what the datastore was
> > returning. This caused problems when mixing variables like:
> > 
> >    RDEPENDS:${PN}:inactiveoverride
> >    RDEPENDS:${BPN}
> > 
> > since key expansion would report key overlap when there was none. This
> > is a bug in the datastore. Fix it and add a test too.
> > 
> > [YOCTO #14088]
> > 
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> >   lib/bb/data_smart.py | 8 ++++----
> >   lib/bb/tests/data.py | 5 +++++
> >   2 files changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
> > index 43e9e78555..65528c6ae6 100644
> > --- a/lib/bb/data_smart.py
> > +++ b/lib/bb/data_smart.py
> > @@ -750,8 +750,6 @@ class DataSmart(MutableMapping):
> >   
> > 
> >   
> > 
> >           if flag == "_content" and local_var is not None and ":append" in local_var and not parsing:
> > -            if not value:
> > -                value = ""
> >               self.need_overrides()
> >               for (r, o) in local_var[":append"]:
> >                   match = True
> > @@ -760,11 +758,11 @@ class DataSmart(MutableMapping):
> >                           if not o2 in self.overrides:
> >                               match = False
> >                   if match:
> > +                    if value is None:
> > +                        value = ""
> >                       value = value + r
> >   
> > 
> >           if flag == "_content" and local_var is not None and ":prepend" in local_var and not parsing:
> > -            if not value:
> > -                value = ""
> >               self.need_overrides()
> >               for (r, o) in local_var[":prepend"]:
> >   
> > 
> > @@ -774,6 +772,8 @@ class DataSmart(MutableMapping):
> >                           if not o2 in self.overrides:
> >                               match = False
> >                   if match:
> > +                    if value is None:
> > +                        value = ""
> >                       value = r + value
> >   
> > 
> >           parser = None
> > diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
> > index 7f1d3ffbbc..e667c7c7d3 100644
> > --- a/lib/bb/tests/data.py
> > +++ b/lib/bb/tests/data.py
> > @@ -405,6 +405,11 @@ class TestOverrides(unittest.TestCase):
> >           bb.data.expandKeys(self.d)
> >           self.assertEqual(self.d.getVar("VERSION"), "2")
> >   
> > 
> > +    def test_append_and_unused_override(self):
> > +        # Had a bug where an unused override append could return "" instead of None
> > +        self.d.setVar("BAR:append:unusedoverride", "testvalue2")
> > +        self.assertEqual(self.d.getVar("BAR"), None)
> 
> Maybe I'm not seeing it but to me the test doesn't match the changes made.
> If the code change turns None into "", how can the assert ever work here?
> I would have expected assertNotEqual or similar here

The code change turns what was a return value of "" into a return value of None. I 
did run the test before and after the change and it seems to be correct?

Put another way, sstting "BAR:append:unusedoverride" shouldn't change BAR from 
None to "" unless the override is active.

Cheers,

Richard






