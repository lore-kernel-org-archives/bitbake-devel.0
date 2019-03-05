Return-Path: <ricardo.ribalda@gmail.com>
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
	[209.85.208.193])
	by mail.openembedded.org (Postfix) with ESMTP id 2E73C7C8D4;
	Tue,  5 Mar 2019 11:00:24 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id g80so7200371ljg.6;
	Tue, 05 Mar 2019 03:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Ebsnqk3F/o0zfz7otEbg+I7wGk6fjNFU4hT/KPVheu8=;
	b=GAYC+bKB7BlBGPIo+WDMNIHKytCKiAudOz/XVosiDm3e70aLMxl3zKgCGDD+u2O13N
	TRzcCZ5De0LO9gNvGs6/blTdkgPoozEzBBq80nmBSUjqACT+BoOXh3c1ubg8SNNrWK3Q
	DRKU8cHN7+V+FDVPhwpyMBrMrpRVDENBYvteH/qRxz6Zkywg7vZ+duaBXQxw0yFV7ZUE
	cMFEIhlipze2xxcob35uLqROc7ZJocNzKZQpfB26H2aD532T9vYTZDi7P4jxWaFxT+i0
	onIuD/9E8vgVWkqPGjHkXIcxgke2hDlzi5TI/aq9HekQ4M14rY19HHrH27OQ3oPObd4a
	OaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Ebsnqk3F/o0zfz7otEbg+I7wGk6fjNFU4hT/KPVheu8=;
	b=MA115KrPTcENhDBpsrx6PNDawEULXQXUl/RuSuurayDUewELbMHv8jQs2wPx9JmjcL
	b5ebT41R7y4aT+xve15ueBgZiuG4GpASIKAm4qepZR4DzshZ1+r090KM5ipGRyegQOJ9
	Qps8DrnPEVKN5557RBaAqkWwPiwV4wmvCKByh2ZyHGuPyJ1NQK5lIksspYB2TLzOZLL4
	g96dMMqiNnZzaJ4ekTw5Jvahz10XeUzLVc6kl0+738kM4V3GLOgQ4sQx/l3sixsTAXYQ
	jajnINDek/4u0gIpGIcrPfdfhuch+eAjMlmAR6Ulq7tZzZ+cVPAmRRcYGcGQbvKmh4iI
	D5Vg==
X-Gm-Message-State: APjAAAVvC/+oKPpn+efWgtqZ/7bdWRAuqBIG5G86H3k23QbZQUa0TaXC
	Rkfn8C77dVpq2dQGfNw7EfjeWZp/uQFF1Xqeq6U=
X-Google-Smtp-Source: APXvYqzJGko83+feCKZVYSg/m+L4fCkJHBx4ErLn7cbVsoc97IZMMSpHGWoW+STrOGbtsGrYl19KLsH5yGp0jQHvY5I=
X-Received: by 2002:a2e:8693:: with SMTP id l19mr10250716lji.65.1551783624644; 
	Tue, 05 Mar 2019 03:00:24 -0800 (PST)
MIME-Version: 1.0
References: <CAPybu_1GLgMMBysaCD0GDiPSmJr6jEqVptzX6+DQmU7ZBOigMA@mail.gmail.com>
	<CAJTo0LYEFB4GyiyP=JK3vj2vFqzT1tzJiERKqezb9BO3N_K25g@mail.gmail.com>
In-Reply-To: <CAJTo0LYEFB4GyiyP=JK3vj2vFqzT1tzJiERKqezb9BO3N_K25g@mail.gmail.com>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Tue, 5 Mar 2019 12:00:07 +0100
Message-ID: <CAPybu_2fbDkuM_kpX4ZbyPw8B8QfS2FEoCXSg1z7gFvfF=gyBg@mail.gmail.com>
To: "Burton, Ross" <ross.burton@intel.com>
X-Mailman-Approved-At: Wed, 06 Mar 2019 08:57:11 +0000
Cc: Daniel Gomez <daniel@qtec.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	openembedded-core <openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] Two recipes providing the same .so... How it should not be done :)
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
X-List-Received-Date: Tue, 05 Mar 2019 11:00:24 -0000
Content-Type: text/plain; charset="UTF-8"

HI Ross
On Tue, Mar 5, 2019 at 11:58 AM Burton, Ross <ross.burton@intel.com> wrote:
>
> Does they literally just provide a libgl.so and no headers, etc?

It provides:

/usr/lib/libGL.so.1.2.0
/usr/lib/libGL.so.1


>
> Ross
>
> On Fri, 1 Mar 2019 at 11:29, Ricardo Ribalda Delgado
> <ricardo.ribalda@gmail.com> wrote:
> >
> > Hello
> >
> > I have a build system that supports some aarch64 machines. For most of
> > the them, the only difference is the kernel configuration, kernel
> > version.
> >
> > I am using multiconfig on my build server and the build goes really
> > fast thanks to all the shared binaries/artifacts.
> >
> > But I have a problem adding a new machine. This machine is also
> > aarch64, with a special kernel (nothing new here), but in this case
> > the vendor provides a binary .so for libgl that is required to get
> > hardware acceleation.
> >
> > I could .bbappend mesa and on the installation part replace libgl with
> > the new .so. But then everything that depends on mesa needs to be
> > rebuilt for that machine and I could not use multiconfig.
> >
> > Instead I have created a new recipe: mesa-gl-replace.bb that has the
> > file. This breakes completely the design of OE, but works.
> >
> > Some snipsets of the "magic" to make it work:
> >
> > #Force that the version is allways higher than the one from mesa:
> > PE = "5"
> >
> > #Rprovide the same as mesa
> > RPROVIDES_libgl-mesa += "libgl"
> >
> > #Do not overwrite pkgdata of mesa
> > PACKAGEFUNCS_append = " rm_pkgdata_runtime"
> > rm_pkgdata_runtime() {
> > rm -rf ${WORKDIR}/pkgdata/runtime/*
> > rm -rf ${WORKDIR}/pkgdata/shlibs2/*
> > }
> >
> > #Keep this on machine
> > PACKAGE_ARCH = "${MACHINE_ARCH}"
> >
> > #Make sure we are not saved as providers for libgl
> > PRIVATE_LIBS = "libGL.so.1"
> >
> > #Avoid sanity checks
> > read_subpackage_metadata () {
> > }
> >
> >
> > If your eyes have not fallen as this point, this means you have a lot
> > of tolerance for crappy code, congrats :)
> >
> > Now the question. Is there a better way to do this?
> >
> > PS: I already tried and failed with update_alternatives
> >
> >
> > Best regards!
> >
> >
> > --
> > Ricardo Ribalda
> > --
> > _______________________________________________
> > Openembedded-core mailing list
> > Openembedded-core@lists.openembedded.org
> > http://lists.openembedded.org/mailman/listinfo/openembedded-core



-- 
Ricardo Ribalda

