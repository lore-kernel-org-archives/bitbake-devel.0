Return-Path: <kweihmann@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C9EC433F5
	for <webhook@archiver.kernel.org>; Fri,  5 Nov 2021 14:20:42 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.92.89.90])
 by mx.groups.io with SMTP id smtpd.web09.6181.1636122041459132494
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Nov 2021 07:20:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@outlook.com header.s=selector1 header.b=iyiioDdw;
 spf=pass (domain: outlook.com, ip: 40.92.89.90,
 mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9+UQpSkEvpdo1lBGVWfcJt7/QB0NtwpJkuB7H37Xr3cQeB5j9PwckXvhYabXmdXz+DYTaz89CCu3p9lx/IaZDISTW4FINHK+1/yZrMphp0qxXG0AQFZiTbidZrnoc2QbDXOTLY/RggPMxN0cen6dEe7x6gbEM/gmqCs9oSWygePxw4esmKDhzyk0ALbPFrVSp4R/0fGwTm6rfCfBqWgsYljswvqTum7khARMexFfO7u3XUGQdSEk9bzOmmqoMhQ+y+918QD5JmW4/diji+1zpiqLG4V7u24W7dE7x4QJSvlkXtECG7LN7kgSCh/m/hYn7z7gEvzZwsG7cIyrLctcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6xJBBdPdSkS8eSY2kdyeZ1fo1/egVEmTUbgEys15v4=;
 b=Phse0/4f1jb5j4HFmS9PbrU5KV1Cxt5NhUVuiIcbgSxHWMhYaviA7G+qktj1B67r5za1MRW/gBQMMam4mo3KnalPx9vAcvWdd9MnMQcdcl67JWVCC9wcoxRLIc1HqZuLV27xOntcyTx+Pic+5T2SmF8JRxM4qivM5opbT4M3FnMsrfLqVPZniAc1APERQUEaO4Wl+Pb6meWGusj5XiOhX7bvNXZK8lfA+v8RqLHRXFFmS35v+sZOTZBOeZIQFpAVAdZsyMv1fGyaimqSW+A73XYjYvKskxOfh7d6+ZmvocWd/NEhWVaOPsCZ5XRrS0ox+qjQyLhDbca9HanLKobh0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6xJBBdPdSkS8eSY2kdyeZ1fo1/egVEmTUbgEys15v4=;
 b=iyiioDdwKWJKKVl4neeDW5xy7SaBnDG5WFq2UcBt6YA1IgMVu2ZAHjMHl+u5Q6g4r/Znozf09KN7AiiDLdRZR+T8gG+qtor7pcnLh22Kt25D07kydxYnJFWmqBvpuxnJg1lyQbskrQuh9ziusc9BktPdolKKM+DdEIfcpvipCZznkLFMmGoOKalC3tjkqe8yXJrqGH6+A+BYPn9Xhc0UKx0z3rWle3U7pfD1EIjy+zbIX+8t6kLVNAu0vtqPJ2Q0cRGZhT4Om7DFusMXKbsLLsAY6frrP4O3PqH6fuZ2bim/+fBTj9SN4dUcF2Q6jKT7Xv7idke8Gpr3A5Sn4QEFTQ==
Received: from AM9PR09MB4642.eurprd09.prod.outlook.com (2603:10a6:20b:284::24)
 by AM9PR09MB4804.eurprd09.prod.outlook.com (2603:10a6:20b:2df::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Fri, 5 Nov
 2021 14:20:39 +0000
Received: from AM9PR09MB4642.eurprd09.prod.outlook.com
 ([fe80::7c6f:9b99:3d00:f710]) by AM9PR09MB4642.eurprd09.prod.outlook.com
 ([fe80::7c6f:9b99:3d00:f710%4]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 14:20:39 +0000
Subject: Re: [bitbake-devel] [oe-core][PATCH 1/2] devtools: Initial recipe for
 repo 2.17.3
To: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>,
 "openembedded-core@lists.openembedded.org"
 <openembedded-core@lists.openembedded.org>,
 "jasper@fancydomain.eu" <jasper@fancydomain.eu>
Cc: "martin@mko.dev" <martin@mko.dev>,
 "Daniel.Baumgart@iris-sensing.net" <Daniel.Baumgart@iris-sensing.net>,
 "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
References: <20211105133104.19895-1-jasper@fancydomain.eu>
 <AM9PR09MB4642AA3727D430C698E95EE5A88E9@AM9PR09MB4642.eurprd09.prod.outlook.com>
 <b8897c8a436f384ef0a41d708816c2f61f9e22c7.camel@iris-sensing.com>
 <d87ff011218f55d97e5aa48ff9b06d216f6d477a.camel@iris-sensing.com>
From: Konrad Weihmann <kweihmann@outlook.com>
Message-ID: 
 <AM9PR09MB4642B8B561D87758C3423C60A88E9@AM9PR09MB4642.eurprd09.prod.outlook.com>
Date: Fri, 5 Nov 2021 15:20:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <d87ff011218f55d97e5aa48ff9b06d216f6d477a.camel@iris-sensing.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TMN: [uAJygU2hel/hcnaxQNsw6jO2mPqesCfXKd3384PscKbqVQAnOVk55ZGbC3hFamI1]
X-ClientProxiedBy: AM0PR04CA0081.eurprd04.prod.outlook.com
 (2603:10a6:208:be::22) To AM9PR09MB4642.eurprd09.prod.outlook.com
 (2603:10a6:20b:284::24)
X-Microsoft-Original-Message-ID: 
 <19afea3a-d699-87c0-93ca-90f5e1c86fd9@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:3103:205c:200:bed3:df7f:f488:16a2]
 (2a02:3103:205c:200:bed3:df7f:f488:16a2) by
 AM0PR04CA0081.eurprd04.prod.outlook.com (2603:10a6:208:be::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Fri, 5 Nov 2021 14:20:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a906d5d7-b709-4b3a-db69-08d9a067716c
X-MS-TrafficTypeDiagnostic: AM9PR09MB4804:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sByBUe9KHwB9R461DoRfGDe5DI/C9fiXyCAh7slz8Wmb+o+WybQQiAs6+78VeO/SuO5FxEEV3MwDsqVzbMHHqOEKsLYxpNXSEEXuKbFy2BJdaMCnS5BPvh/llCT9Ud0GblIEBYwZ6GLq7VP9V5mLBUgXheE+HV03BZKKo0pkruF0s/Cjl4M2SA+VnMSnCuQNj8RjC9Oq+wem5J0lPdb6zVktTGWDsJUVfUeJh0XsiPblU296M3ZtJYLYhTxGjKMN5VpSEXkKP+xbHif938YPzIQwHYiGXRmXYinwTN9xWwIZ9BI5s9zYtzuBV8wV0ByFhKtcCqDlkFOYoqd930HbsOFyxXJn/cAM0L44vzoKunCVgSlIqkLbKE8rNEMbiwgRBH3fQUmZcYLxWVfJFCljN6Cr8vQGgLbVzjPtmqPXm6rwwrWB/o9NhvLs92kPrQyK2/WFtzAgOLUNcGvBj4eKmkEC6XKw48NyTZdbwRfRuQKBUJAauWVKXk55nKk7DcRwXdv+16iDxD/c++j4zwv14dgwUeJHNjrkQAyudVpphdE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	BAQQvRKlBWBDwEqqewurFFOifusZzpFKFnvpkYtPumoB407FlR+gqmhphzk8WFQ1I0Py/pdjH9J2eCutkeVUZUJcjUkCbhgMVVM8ox2b0wPyUpYAeaCNkOJiNWk+qkUIY+1xowl/k5WVIn7meXdnehd/RG/dGUoAGd19AC7zQ6+ih2PLiXq+LMW6Eb6AoiWJA6KBLbXWDOklc+6pt8Ep6YtFBaWcmgxxsZZBgx/8JH8vDuvb12yr7i4ikiUKN21PSa+uGb/KK0wTa4UakL2gKDJfN1/66bUccD+tIkLSV7DZ1WwyU3fdQqCkzz09GdBkLEPRIuNyG5rXSzpp+bfqWI6TDSnpq4ItXF1Bha04Jw/8qiaLM2KB/2RMhl2Rxudfo6DQMoiCAJOn8QUw87b0YWxjfHUZ37+x5GiHojxpi0druvIbQGVCrj99uC6U9mG1jKfU9TDusuXEx+b3z56F/H5sNNm8I/noD4luldGpfxqtuElgkx/QwqK1IM5G4Cj6SRNNdXNmdEaAuwxsdNI5dNQHMHt7Zs2kfZiXhD2Z2ELQqcFdoRzcV8+JoJxgCAgHsI8fvUT7YG5ZxXzijs8S7GwWTK7O5kbvTw9SQu1nAAMB8HAMkJHBonkpbbmg8njaOlb01zcFN6V/fkfzntSIaYviD1ecPxXxJoTmsdBirlVjZPE42j/2DIqzzElbpl6j0QM0OMSNCEnqzZ5xqwk37+i+VyBio/qTHX+FfQ1ZRosVDbP5FxfmoTB7dKS359lcPNXOWkc/ss2ieyWypczMyg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 a906d5d7-b709-4b3a-db69-08d9a067716c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4642.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 14:20:39.6901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR09MB4804
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Nov 2021 14:20:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12899



On 05.11.21 15:09, Jasper Orschulko wrote:
> Actually, I don't believe this to be an issue for the following
> reasons:
> 
> 1. The recipe does nothing more than taking the wrapper script as is
> and copying it to the sysroot. As the repo binary is never called when
> building, it does not have the "chance" to look for an update during
> the yocto offline build process. The outcome of an offline build is
> therefore predictable.
> 
> 2. When using repo within the yocto build itself (with the repo
> fetcher), the repo binary is only ever called during the do_fetch step,
> which obviously has no issues with any network access.
> 
 >

Okay fine that makes sense, even if it is still phoning home.
Another thing, could you please exchange "+REPO_REV = 'v2.17.3'" for a 
SHA revision, as I wouldn't bet my life on google not deleting/removing 
tags from their repos - and unpleasantly we wouldn't even notice that easily

