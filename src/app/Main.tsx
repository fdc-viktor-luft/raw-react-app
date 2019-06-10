import React, { useEffect, useContext } from 'react';
import { ArticleList } from './article/ArticleList';
import { Webservice } from './Webservice';
import { Icon } from '../icons/icon';
import { Store, StoreState } from './Store';

export const Main: React.FC = () => {
    const { articles, filter } = useContext(Store);

    useEffect(() => {
        Webservice.getArticles().then(articles => {
            StoreState.set({ articles });
        });
    }, []);

    if (!articles)
        return (
            <main className="loading">
                <Icon.Spinner className="big-spinner" />
            </main>
        );

    return (
        <main>
            <ArticleList articles={articles.filter(article => !filter || article.title.indexOf(filter) !== -1)} />
        </main>
    );
};
