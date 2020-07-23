import React, {useEffect, useState} from 'react';

import './style.css';

import useApi from '../../hooks/api';

import Card from '../../materials/Card';

import Grid from '@material-ui/core/Grid';
import Paper from '@material-ui/core/Paper';
import SearchIcon from "@material-ui/icons/Search";
import TextField from '@material-ui/core/TextField';
import { makeStyles } from '@material-ui/core/styles';
import CircularProgress from '@material-ui/core/CircularProgress';
import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import Typography from '@material-ui/core/Typography';

const useStyles = makeStyles((theme) => ({
    header: {
        // paddingTop: 20,
        textAlign: 'center',
    },
    paper: {
        margin: 'auto',
        maxHeight: '100%',
        // maxWidth: 500,
        padding: theme.spacing(2),
        backgroundColor: '#FFFFF',
    },
    title: {
        flexGrow: 1,
        textAlign: 'center',
    },
  }));

const styled = {
    header: {
        height: 140,
        paddingTop: 5,
        textAlign: 'center',
    },
    content: {
        paddingTop: 20,
        maxHeight: '100%',
    },
    positionLoading: {
        textAlign: 'center',  
        marginBottom: 500,
    },
    loading: {
        width: 60,
        height: 60,
    },
    appBar: {
        backgroundColor: '#2B9EF3',
    }
}

const Post = props => {
    const classes = useStyles();
    const {
        data, loading, 
        fetchTime, limitTitle,
        limitContent, fetchImage, searchPost,
    } = useApi();

    return (
        <div>
            <Grid container spacing={1}>
                <AppBar position="static" style={styled.appBar}>
                    <Toolbar>
                    <Typography variant="h6" className={classes.title}>
                        Portal Berita
                    </Typography>
                    </Toolbar>
                </AppBar>
                <Grid item md={3} xs={12}></Grid>
                <Grid item md={6} xs={12}>
                    <Paper className={classes.paper}>
                        <div className={classes.header}>
                            <Grid container spacing={1} alignItems="flex-end">
                                <Grid item md={4} xs={2} sm={4}></Grid>
                                <Grid item>
                                    <SearchIcon />
                                </Grid>
                                <Grid item>
                                    <TextField 
                                        fullWidth={true}
                                        label="Search" 
                                        id="input-with-icon-grid" 
                                        onKeyUp={searchPost}
                                    />
                                </Grid>
                            </Grid>
                        </div>
                        <div style={styled.content}>
                            {/* <div className={classes.root}> */}
                                {/* <Paper className={classes.paper}> */}
                                    { data.length > 0
                                    && data.map((item, index) => {
                                        let time    = fetchTime(item);
                                        let title   = limitTitle(item);
                                        let image   = fetchImage(item);
                                        let content = limitContent(item);

                                        return <Card
                                            key={index} 
                                            time={time}
                                            image={image}
                                            title={title} 
                                            content={content}
                                        />    
                                    })}
                                    {loading
                                        && <div style={styled.positionLoading} > 
                                                <CircularProgress style={styled.loading} /> 
                                            </div>
                                    }
                                {/* </Paper> */}
                            {/* </div> */}
                        </div>
                    </Paper>
                </Grid>
            </Grid>
        </div>
    )
}

export default Post;